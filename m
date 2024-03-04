Return-Path: <linux-kernel+bounces-91360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D20C6870FFE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64FC92839AB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D3E7BB14;
	Mon,  4 Mar 2024 22:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="kJFvnU9b"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10C47A70D;
	Mon,  4 Mar 2024 22:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590666; cv=none; b=ddB2PHBIu5TgzXqCaH9xlE+JlE7ApTRC7KkRBfrgifRojVrBzOTam49XB1I7CNLe7AM+FNp1tM+GeKFSro16n8H1bA8ht7ejBa25Xtz7KBB0wkJh6LWmNFOdwBmchQHHKCNNZuLDTpCDSoP3wmVPbBTqaVTOxM6xwgYpb2738vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590666; c=relaxed/simple;
	bh=N69BwmLeOR2BwIa3WKb1T5Fo2cdv/XGckUP8Al75eig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CX6FE61ZU/JAodolqNTdlRWmGkMvms8exKhugM7xSmbyKSf8mt++QG4ZdOyY7rZdO4b+klR5zuLC5/EKz45o0jbHAlqLM/U3AzlTBv1OJXNebujBMcORODu86EVyayvJ+PtMFIMROcbL0h02/HJdxHVfDZJ/oequKu2EDbkeXWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=kJFvnU9b; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709590657; x=1710195457; i=w_armin@gmx.de;
	bh=N69BwmLeOR2BwIa3WKb1T5Fo2cdv/XGckUP8Al75eig=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=kJFvnU9boms2Z7GpjBTRcbYllti7GVGLaK8ycED8g/k3JAXUrC8gNdKIhLGUt2Lp
	 uqRiAULZHW08PxpQoEJGD4QEg3LL8CifY0HVSkNCtPmo26+BEFLaIPIx8lywoZaxV
	 r6duU14XftSNKAuFOOMCWHj5uplZlB+A2MAIb5PMEskz1FeIehyZankYx0OOO6u+5
	 C77ATZGKtkFCeJBWwctbZORkY0UR5MGIl3IvfMii6OE1Bf/78nhkpZvpv6dXZzHfo
	 fSxh1hQQtaR4aUkk1CN1GEKbTo5TABj6C1b7SNorcaY8ORX4Cvrro53XYOsfVDM+2
	 lhDKrfYC4ogn4NbDnQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MBDjA-1rZ3AU47kE-00Clku; Mon, 04 Mar 2024 23:17:37 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: wmi: Avoid returning AE_OK upon unknown error
Date: Mon,  4 Mar 2024 23:17:32 +0100
Message-Id: <20240304221732.39272-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240304221732.39272-1-W_Armin@gmx.de>
References: <20240304221732.39272-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IkVjgd3JgIQlLQO2ZiyszhLHhBFvXMgE/tjmIKdzZ5l5y71bKzc
 +99avk5zC8ZQpBFKQCg3qvTXUwWr/8HqdaNHj3w1DNvFFAGrGePHReHT3x/sYIfTp0kLKtp
 og9bp5QwPXHrTz7h0SBi7vNopy0Wkvsc9ETaFwhEmif+Rlyyr4oVxQxcGaEIANm9lM+AXy9
 l9b+JCbQBA2VvP/VbvT/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:D9sspd2i+2k=;O2NRNAjApf6ySKwwK8zws3+M9K5
 fSmi0jxQQvaveX/VGYWm8/Ce20SfpSwVi+3SjzZYhtyagsdNwFLnUg3kPbgwhdMsk0E5LEyjH
 Nay2xwdKWQfykbzlX6YZIEvHHfjWLDz6S9oMERL2eSPLWG/ROCOApjrpEMEcS7x5xqFGK/mri
 7Q2g/aCzvrLKvVrVgSufVUTnukWZ2VKKOi1hpWorT4HxgAdEYnWpwV9NW0Quo8qDBYTjxR7ba
 MZ5azfY59xYXNNlfhN+WoNZo8rddcf2i69ivr1kKG8CJWAF8MEsi0OKGSVYzfqkXhsIBZtkfO
 DevKTsm1Tp+XzJUoZTLlPYLgzHQIfP43ZFDzxX225z33NPn+kfEV4U+O9nmVtz4M7mmCTnH3E
 HrqQ1P2maawiyjftgeowjNgSjGYuDUjTRNphSXZj3EsTHNbCj6GJX9q0zI6Wojx8S9ZUts7fh
 8qWXC5kNbhL2Mcbo/1H5tCt/gdA6PTTJpj76DaTzVxwS90d6+Iv4fbNA8XieNjJTSu5ot6yAx
 NeEzmlu+R1f4VDOjO0WIJev34Ov0bRx8WdmgIbOBDjZcfEY89J2F3i2tL779Y5QgjQKScEmgX
 51FSE1XfDFiuq1LuCbNrx8g+b/mpcI+HTwJnH7ei5HiUJ9n+fKtSfwLgXwnujnpybbZySIcET
 k4PeAIkX4DS71En1dotMCNISb2SCERdVhQvOVlskclhH3fUealYqceTYbS2jBV8Txh9zCB4EL
 2s2KA4djkG0aqvUFy9AWbUn6jOtiJ2O9VW9B3BST0QtBVYEvOdRNXI6D19p7Fm3HjfBdjC49l
 vSGGojH8QllsAvjvVGDrXQ9DZv62JD6b/OMqfRBd6ak4w=

If an error code other than EINVAL, ENODEV or ETIME is returned
by ec_read()/ec_write(), then AE_OK is wrongly returned.

Fix this by only returning AE_OK if the return code is 0, and
return AE_ERROR otherwise.

Tested on a Dell Inspiron 3505 and a Asus Prime B650-Plus.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 900e0e52a5fa..be0e772a87c8 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1213,8 +1213,10 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physic=
al_address address,
 		return AE_NOT_FOUND;
 	case -ETIME:
 		return AE_TIME;
-	default:
+	case 0:
 		return AE_OK;
+	default:
+		return AE_ERROR;
 	}
 }

=2D-
2.39.2


