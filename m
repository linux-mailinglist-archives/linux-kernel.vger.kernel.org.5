Return-Path: <linux-kernel+bounces-97521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDC3876B60
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F00C1C20A09
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C9B5D486;
	Fri,  8 Mar 2024 19:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="hOCree/y"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D295A5A7B8;
	Fri,  8 Mar 2024 19:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709927448; cv=none; b=hhZrWnia7ESki6udLodpMOItQK2qGo660BbPiJtoz/+f4XbVBqemUPqugimhTqtzt50PWIJ4rOClCdAH0icRi7SbENO0A9zRcWJMrluq2Ah548ZCA9e+bvW0MF/8kvq0iHtFdRawQNX8VU2WfBReHnggz1VIe9f8mFGt9GD18Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709927448; c=relaxed/simple;
	bh=SE7zZzdSvh30m3p68BbPZ7PZvfih8AStt4mVSuZXlMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kRfMv+MuMBGRezFKNU+nfLSNzY/RX/l/oC/9JxqyIO0x9AfIW8ShLVXO1jMlUsjW5WZppR3i60zeOqvSnqN/M7Tho395Yoipat7ODK1tcZqHb4d6uSRILwkWmXh3Ag+SEPvj6z6LePVDoU63d2k9JrQQPiIKZWmifbZqotneTQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=hOCree/y; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709927436; x=1710532236; i=w_armin@gmx.de;
	bh=SE7zZzdSvh30m3p68BbPZ7PZvfih8AStt4mVSuZXlMk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=hOCree/y5KKagT876Co36RG9EwUcq85pBrx4D7n3eVQZFKs5fWLvkT403q2Q8gQ+
	 g53m+qreWs4dQbiktdz263B+CNDZJDe4nblC+lhGAIb+edxZwCUpvOVJ3J61BGlD9
	 sBnpIttklFQbXQl2iVS2OoXQiL+q2jt6hQq6ndRnohbD050ZhO02I7MqRrlaCr2Bx
	 6vaJyUnCbffF/fKwTVvdo7hR8xW0/K+O48ucsFPBdkcnvixWQf7KjimEMHnSXBGF2
	 djO3fA+TttqM1wk1i7e1/NTd1B5Ub6LIRE6nArjbS0J6DIvtuarTy8BuE5YXCm7r2
	 EFF4fSEwMxLECtM8bw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MjS9I-1qy1xJ3OtG-00kvMF; Fri, 08 Mar 2024 20:50:35 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] platform/x86: wmi: Avoid returning AE_OK upon unknown error
Date: Fri,  8 Mar 2024 20:50:27 +0100
Message-Id: <20240308195027.7640-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240308195027.7640-1-W_Armin@gmx.de>
References: <20240308195027.7640-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ITvl0mwxzK0bYYhNzD8L/9G/fdu5flI0mYdYIo9Z6G96G7zuxVy
 TCgKocEUY3O3VtSA3ZRB0mMHR6HVIPaN72tOB1s8jMbUDGHg9VzZWgdSUudBRAd9JCx/VhB
 liOPmxfLd7ArLW4y8bWwpAY0FIkA1uHxQVVW5uob00T6rXiC5hXPgnghg4/RQsiKgYfdomi
 AnLL7x+WC4oMC3IaH4JBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lRGWUd8rbD0=;S3VNApLh4SSMB/cUCUVGpwJPrjz
 h5eQf1dROgx3oZVf/8xQGNV0k6XtXXV8FWFd3Yr8w/Yabdiq+jSg34WPPEAcF3m/Ib54+cEuc
 Ub6B9cV55OsaSP6Wp/i2S/NKv+q5M+B/vBTsjjcI6XTfvp5Rqhj3cP1m/XiiJMXrhgq6ddYLa
 E6mENN2PyYknmTtjnjr4k3YeIt4A/z8CZLD8gHqd5ySbE0N+zO6aeQksHNNaBs/EMJ6QuQSh4
 3cNvv+X1ESsA7HHAx+M1uJoMJ08QFaMlPSAgrmLeat/vIZa2rD/4zJy/s9haAVFtF+ELI4WBX
 vkqGcCGxTZF3e/XM7I7KFPSLGlSqW+jijtxVgcqR06Tca/8fHjVnZn5XkcnRMiXGXDjAmYduv
 QJUESLKDgAvMKj30UFfFdKkKRlRsgcJ28z1qz0SZETLh6gn3CFoiZ1Ash1Omk2vLVCOcZhkEb
 /yo/sxM6045buMO4JYG7Ji8N0Am5nuNa3vd+eop2c72trHw9aNXwV+L3xqisriVlgvP4KE5rL
 pooYk1gxvWpTS5LMzdtT8K4qHXzacdwBSGlWmhirbTGlU2gnURealpnC2OlRqK3qAhPUNOm6p
 EDPlKkIlf9/i527HYGkBL0SsBmRYLKF2/Yc4wfEoRr1FK9TvKlTY7w5yoAeCTTZJf7VFyiuFn
 9RmK8EIGeE21bprwRQ9jKLILWR+SjkFBdS8HrEBbY6J0H9n9cI3ytzPryx3fuVewI/rKKTXxv
 mezBTxKN2GhhztIlC7eY6NCig0P77htw1B13Wwf/WegziETdaPno2aj1CKr8cZaaV4dkgML5v
 hkK2awNic2ugRPZEztS3lOvevY3K+XmkYRPAKRbR2C+Dw=

If an error code other than EINVAL, ENODEV or ETIME is returned
by ec_read()/ec_write(), then AE_OK is wrongly returned.

Fix this by only returning AE_OK if the return code is 0, and
return AE_ERROR otherwise.

Tested on a Dell Inspiron 3505 and a Asus Prime B650-Plus.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index e6cab1cf611a..3f75220558aa 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1216,8 +1216,10 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physic=
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


