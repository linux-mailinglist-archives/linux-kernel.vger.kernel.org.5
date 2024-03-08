Return-Path: <linux-kernel+bounces-97591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D54AA876C44
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A041F220C1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C3A5FB9B;
	Fri,  8 Mar 2024 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="L39jFG3K"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2715E097;
	Fri,  8 Mar 2024 21:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709931942; cv=none; b=KwkF+byzu2w50Xn6jgyYblTuJ92d5btAU8NQmTeTYeUKo6zSEXvihwUAhFNJkjbB40m/FL3BCqc1Pe2wF5U1DhCA7xvF7i43xPu6Y3jwX+e2j7VkkQcB6q3HTNvSTQ3aKh37GcAgHPn+Ekxm8m4tmM5191erq3c1rVuTnLI/X7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709931942; c=relaxed/simple;
	bh=rie7fmUkfM0m8cYoiL41OvyYJnWYQxdPB6xJIoQaK9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MXrI8I2g32dbFDS9Y/3xU+fnAvn3pAGlOoGts3R31aGtucxNr+zYGHnFRL0Unu4rv04kWyYIltzL3UMZKzBD0zfJAQP2isno6JotjgQaptrK9AE14o5JTJxU2RdgAqNJfcD6ZJKbgsKPtajGFhU9ZT0Mtk8dFZSOAaJOSihKIvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=L39jFG3K; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709931925; x=1710536725; i=w_armin@gmx.de;
	bh=rie7fmUkfM0m8cYoiL41OvyYJnWYQxdPB6xJIoQaK9s=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=L39jFG3KNdJcYIR9zz3ekYOkp2bOXpYWBJRjgHf6M1H7MkEJOS03CNer5FC4SYSD
	 diZOsPHUUtgwclVt/44iM15F4RE6MmYqyMK+0tCiySIVRkSagSCrN7Tqdmy0hhnEZ
	 n/OGfljVzTozinBPkN18fn5cQx5xYeywFNElafmBRY6zpy2rlAWatoJFSPV+3m49L
	 6BB6ux0+0jrSQ+IkxRuhFEPa3uJ+ofCv7ugoRkWBFsydMPsMMsfedk/cYV0xhReDG
	 FeCsS4yqJMPwa9I8PkPIiXHi3WUlog++w+n/XydStTXdyvFrDhgUcTvVUpbqxAqNR
	 OtuG51uesGca3k4oRw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M4b1o-1rjFMx1aQo-001ffC; Fri, 08 Mar 2024 22:05:25 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: rafael@kernel.org,
	lenb@kernel.org,
	mario.limonciello@amd.com,
	linux-acpi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] platform/x86: wmi: Avoid returning AE_OK upon unknown error
Date: Fri,  8 Mar 2024 22:05:19 +0100
Message-Id: <20240308210519.2986-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240308210519.2986-1-W_Armin@gmx.de>
References: <20240308210519.2986-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J8S3T8zp0/viK1dNI8/U0HtfNcG/2RqO6qETHNtIOpdJOTdw7aY
 dc0trKA0CKu64SvWOg7QyiWJhj4s8q32AXLjGFFdHh0SrmTi8qF05n52rfEJwV5bqTsdI8G
 shFXP8BI7a68NO2FeodXM5bNArk+uCVOO2tJNPGUJgzX4dyv8M6wytY9C7GbsKYX38IiSxX
 3H0k5bJJg5BM0L+ALQBbg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BPecIgapw+s=;3D0P6lza2e4okWHFLcxGy2BWAkV
 fXzvhW2hfKFClJjnAY1WCgam42VPDx0+TZ0X3qBLJrQkeIea371hZfz8GJEOU+UUx8oaDFJA0
 VadTHmbSG8gVhoh6jW9poR0iQmKIAnNJOiP5B5ByXVsrM5aQmorpsR9GDOyewdspExGZCqyXk
 FhyqbNoDswqr5xymAZFsj3uYPJQQMkL1m96VRa10/UxMK6WxZQ07ufMD/t6LZ+WLzOBoXlyWb
 BdOc4wMVRVWyBSaTH3tJnAQQAlWfn8k0P98w0YZFt+Z89hA0ozCaK+lsbBtxa2fZR3XPY17eT
 0M5RTeqaJeDTdm8grZYafstoPCnKrHoRusICjgqBoLMFvf2vIQTlgGB/+yQQpFobx/3AmcWv9
 t4KBtQbt/fVGvoKC3i2kHk7m2r1RPQDYWiO+7IKJhuYw+ftwW18Z5+mvHciEOEbZquJPz2S26
 3OJNdnvnoOR7sPz731kw5Od4nipihAdhc7ZehURUGeN2cfkdgpQYN3NywgWVD3IUVVCPhze4A
 5gKR8yeurRC3KiCoZ+cUaCHVueXa837OPFkeSgWNLl7VieUFSN3Wrb71tEqUtdZLxsYexXPAl
 F4w6/axQdP73KbhCtY17qUF3sdolTl+VJSOF908cwWK9YpT+XM089+TO6xk/YH6lTEmIXPGCw
 8dQKjSJmn8rgkd6HaTyG0iE2QlfyDrYi3K17CthJQ4u6KeFc28CYFApqWU0RG1YDogKgp09cB
 AWICj/ckXLYj3ANjPdf3kNWZLSdzbov2MNUm73rK+ZIFhZ8cjlsii3Qqb0YZyJQrDXTrmBOvl
 +ipnhgRCxRFlQe4FjuVEJV7vdJ4QG/i97SoHWZGRibImc=

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
index d9bf6d452b3a..84d1ccf6bc14 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1218,8 +1218,10 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physic=
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


