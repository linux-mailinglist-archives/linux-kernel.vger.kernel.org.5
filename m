Return-Path: <linux-kernel+bounces-35195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E217838D62
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22F3287DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137215D74A;
	Tue, 23 Jan 2024 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IGF0aFyC"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7795D720
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706009216; cv=none; b=O2rrEEde3Z9MMoltAwWGb2s7BBDS5re7p5Ol1EdAHLxSGBsFyAnFbeu06dXnoSswGBAqQ1F0X1IdJSrs8Iz5dsQQ//idktwq6J8SfQZPlzE1cZG03W1Byx0z8Ka5fKz462Ftf8NC82JF/Tkri3mwlEEMrVor83NDXsUzjgHHHa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706009216; c=relaxed/simple;
	bh=MX7FTiphx3ByTo0Q61XpSxbHsVcB1BXGvp1XkoqI3Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGVOMp4a/2Zgzkr3aj/zVXf7NTcuaOdQxW6btRBnT4WIdALAJHSNnGrz7uWdVJ4XDcK+mVVfDP7fZnF5xErZ3Rq8/mYX651Xm0cDgpbMFzxzxDmL2wNhYF/MiVKDA8+yi/wzCWR5U0vnBlA5ReJ1NAd1ptMBjpJ+8rARV/T44VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IGF0aFyC reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 138A040E01BB;
	Tue, 23 Jan 2024 11:26:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BgJnHJaPJdCI; Tue, 23 Jan 2024 11:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706009207; bh=7LXfm7XElOBij+WLqGVs9ad6dE4CTkuurUWn+UOIq0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IGF0aFyCwjcMSG6X6rrOug7/lQ0fxAVANCPYZrdR2AM/+V6x19KE/wdhjIowlfsMF
	 0r45/zSxd/rFmrEg7pE+csLgoeh3ci559X3itw2H04LcFsiBdA31abtymIot4tRn1z
	 vDKv1FQNqV9W3YI9l/aWLl+A0Dvy0N5iQcWsm9uFxmHP8iJS7A3brU2pY+tEEPKDF7
	 3o2F6O7Sg2kes6guRyVuiNU4XnL4xCG/DN8SqNYCijJtG/J6+b8Nkp3KahZ945aoXP
	 qrUXZHEIYLqjXJEsHiJ8mG+j8uXqwD3kl1gktJN4S4fBaTo6rLZo2pwxMnZtHa20mf
	 Nim2TGmshnj4tSMo+u1GiiIrB/oiyHCeA8dxdPeojOPoeypbyleMxcUQ5llBdlJ0ho
	 u8iBmvTPzcyL5eno81hcHpCpVDx20SsUH+8TcfQ+QgjDr20Gm+a5f6VTPFJFrKtHaf
	 P7oOZBrCdPBX2qjb4UJz4Ie06zBo2Xi2AAdQqgueyx0eZ8a1z5qAnzum+A+Bvw/fQ5
	 SyVvG9QY6lrSL2ElAOn4p1y7TGMk0Rc1nTJIkz/GFPidmNMN0w3kd09Fh0gGb72XxD
	 GdPv0CFRLTOfq25yfTRxpq0uQfCZJ80vouSeGzr+gCgiEo53y/l8D8et5cLG1DiEw/
	 +peCVtEYNqU240vRD4LdPmFM=
Received: from zn.tnic (pd953099d.dip0.t-ipconnect.de [217.83.9.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4DAE440E00C5;
	Tue, 23 Jan 2024 11:26:31 +0000 (UTC)
Date: Tue, 23 Jan 2024 12:26:24 +0100
From: Borislav Petkov <bp@alien8.de>
To: NOMURA =?utf-8?B?SlVOSUNISSjph47mnZHjgIDmt7PkuIAp?= <junichi.nomura@nec.com>
Cc: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"david@redhat.com" <david@redhat.com>,
	"nikunj@amd.com" <nikunj@amd.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"debarbos@redhat.com" <debarbos@redhat.com>,
	"jlelli@redhat.com" <jlelli@redhat.com>,
	"lgoncalv@redhat.com" <lgoncalv@redhat.com>,
	"dzickus@redhat.com" <dzickus@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Add a message about ignored early NMIs
Message-ID: <20240123112624.GBZa-iYP1l9SSYtr-V@fat_crate.local>
References: <ZaEe8FC767f+sxRQ@jeru.linux.bs1.fc.nec.co.jp>
 <20240112120616.5zjojjmjeqg5egb7@box>
 <ZaTziftQSSg/v5Np@jeru.linux.bs1.fc.nec.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZaTziftQSSg/v5Np@jeru.linux.bs1.fc.nec.co.jp>
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 08:57:45AM +0000, NOMURA JUNICHI(=E9=87=8E=E6=9D=91=
 =E6=B7=B3=E4=B8=80) wrote:
> +	if (spurious_nmi_count) {
> +		error_putstr("Spurious early NMI ignored. Number of NMIs: 0x");
> +		error_puthex(spurious_nmi_count);
> +		error_putstr("\n");

Uff, that's just silly:

Spurious early NMIs ignored: 0x0000000000000017

Would you like to add a error_putnum() or so in a prepatch which would
make this output

Spurious early NMIs ignored: 23.

?

So that it is human readable and doesn't make me wonder what that hex
value is supposed to mean?

Thx.

Btw, please use this version when sending next time:

---
From: =3D?UTF-8?q?NOMURA=3D20JUNICHI=3D28=3DE9=3D87=3D8E=3DE6=3D9D=3D91=3D=
20=3DE6=3DB7=3DB3=3DE4=3DB8=3D80?=3D
 =3D?UTF-8?q?=3D29?=3D <junichi.nomura@nec.com>
Date: Mon, 15 Jan 2024 08:57:45 +0000
Subject: [PATCH] x86/boot: Add a message about ignored early NMIs

Commit

  78a509fba9c9 ("x86/boot: Ignore NMIs during very early boot")

added an empty handler in early boot stage to avoid boot failure due to
spurious NMIs.

Add a diagnostic message to show when early NMIs have occurred and/or
what happened to them.

  [ bp: Touchups. ]

Suggested-by: Borislav Petkov <bp@alien8.de>
Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Jun'ichi Nomura <junichi.nomura@nec.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/lkml/20231130103339.GCZWhlA196uRklTMNF@fat_=
crate.local
---
 arch/x86/boot/compressed/ident_map_64.c | 2 +-
 arch/x86/boot/compressed/misc.c         | 7 +++++++
 arch/x86/boot/compressed/misc.h         | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/comp=
ressed/ident_map_64.c
index ff09ca6dbb87..909f2a35b60c 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -389,5 +389,5 @@ void do_boot_page_fault(struct pt_regs *regs, unsigne=
d long error_code)
=20
 void do_boot_nmi_trap(struct pt_regs *regs, unsigned long error_code)
 {
-	/* Empty handler to ignore NMI during early boot */
+	spurious_nmi_count++;
 }
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/m=
isc.c
index b99e08e6815b..e7f4eb24a9a4 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -52,6 +52,7 @@ struct port_io_ops pio_ops;
=20
 memptr free_mem_ptr;
 memptr free_mem_end_ptr;
+int spurious_nmi_count;
=20
 static char *vidmem;
 static int vidport;
@@ -493,6 +494,12 @@ asmlinkage __visible void *extract_kernel(void *rmod=
e, unsigned char *output)
 	/* Disable exception handling before booting the kernel */
 	cleanup_exception_handling();
=20
+	if (spurious_nmi_count) {
+		error_putstr("Spurious early NMIs ignored: 0x");
+		error_puthex(spurious_nmi_count);
+		error_putstr("\n");
+	}
+
 	return output + entry_offset;
 }
=20
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/m=
isc.h
index bc2f0f17fb90..b858d6aa648c 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -59,6 +59,7 @@ extern char _head[], _end[];
 /* misc.c */
 extern memptr free_mem_ptr;
 extern memptr free_mem_end_ptr;
+extern int spurious_nmi_count;
 void *malloc(int size);
 void free(void *where);
 void __putstr(const char *s);
--=20
2.43.0



--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

