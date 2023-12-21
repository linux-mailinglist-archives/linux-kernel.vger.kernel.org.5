Return-Path: <linux-kernel+bounces-8314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1A881B57F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2AB2841F7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D05B6E2BF;
	Thu, 21 Dec 2023 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="UXZ/8iFV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31C96E587
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1703160590;
	bh=HNgAHhgASKG5cC6HA2RaRQqlTLp7bCesqBG34hJxbJ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UXZ/8iFVFD0RXlNf75DnRzeZjZNqxXdyWlv4k0Hzlfir+cyDg6bzbTkZMQcPEURyP
	 dkTVRxehX5RuNr+aZND8OtKcWszFbK6k8UWIfrAKKvTgU9KtM25R6X2RYV/TGCXe6F
	 dv3/5yh5p0aHNYb1dftrqTuQJW3EQkuse3SZQhoQ3nerzOI/8Hr7sc9fVzUv2thna5
	 5bnMvnqnCaA1nr0WKnr8U1Ey0AxGM5PNK0A7spgyNi6bRYwkuTIqnw5sBIKTD0uOM9
	 mYBPuNRUGXdrNxN4h69hABS+DC8IOmVR3y0cPrdjoAD+ad6Soy4Sk6Z1YFgCc0rcmP
	 OL68MK1PQoxAQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Swq4G3W56z4xCg;
	Thu, 21 Dec 2023 23:09:50 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Nicholas Miehlbradt
 <nicholas@linux.ibm.com>, "glider@google.com" <glider@google.com>,
 "elver@google.com" <elver@google.com>, "dvyukov@google.com"
 <dvyukov@google.com>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "npiggin@gmail.com" <npiggin@gmail.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, "kasan-dev@googlegroups.com"
 <kasan-dev@googlegroups.com>, "iii@linux.ibm.com" <iii@linux.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/13] hvc: Fix use of uninitialized array in udbg_hvc_putc
In-Reply-To: <aab89390-264f-49bd-8e6e-b69de7f8c526@csgroup.eu>
References: <20231214055539.9420-1-nicholas@linux.ibm.com>
 <20231214055539.9420-3-nicholas@linux.ibm.com>
 <aab89390-264f-49bd-8e6e-b69de7f8c526@csgroup.eu>
Date: Thu, 21 Dec 2023 23:09:49 +1100
Message-ID: <87frzvlpte.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 14/12/2023 =C3=A0 06:55, Nicholas Miehlbradt a =C3=A9crit=C2=A0:
>> All elements of bounce_buffer are eventually read and passed to the
>> hypervisor so it should probably be fully initialized.
>
> should or shall ?
>
>>=20
>> Signed-off-by: Nicholas Miehlbradt <nicholas@linux.ibm.com>
>
> Should be a Fixed: tag ?
>
>> ---
>>   drivers/tty/hvc/hvc_vio.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/tty/hvc/hvc_vio.c b/drivers/tty/hvc/hvc_vio.c
>> index 736b230f5ec0..1e88bfcdde20 100644
>> --- a/drivers/tty/hvc/hvc_vio.c
>> +++ b/drivers/tty/hvc/hvc_vio.c
>> @@ -227,7 +227,7 @@ static const struct hv_ops hvterm_hvsi_ops =3D {
>>   static void udbg_hvc_putc(char c)
>>   {
>>   	int count =3D -1;
>> -	unsigned char bounce_buffer[16];
>> +	unsigned char bounce_buffer[16] =3D { 0 };
>
> Why 16 while we have a count of 1 in the call to hvterm_raw_put_chars() ?

Because hvterm_raw_put_chars() calls hvc_put_chars() which requires a 16
byte buffer, because it passes the buffer directly to firmware which
expects a 16 byte buffer.

It's a pretty horrible calling convention, but I guess it's to avoid
needing another bounce buffer inside hvc_put_chars().

We should probably do the change below, to at least document the
interface better.

cheers


diff --git a/arch/powerpc/include/asm/hvconsole.h b/arch/powerpc/include/as=
m/hvconsole.h
index ccb2034506f0..0ee7ed019e23 100644
--- a/arch/powerpc/include/asm/hvconsole.h
+++ b/arch/powerpc/include/asm/hvconsole.h
@@ -22,7 +22,7 @@
  * parm is included to conform to put_chars() function pointer template
  */
 extern int hvc_get_chars(uint32_t vtermno, char *buf, int count);
-extern int hvc_put_chars(uint32_t vtermno, const char *buf, int count);
+extern int hvc_put_chars(uint32_t vtermno, const char buf[16], int count);

 /* Provided by HVC VIO */
 void hvc_vio_init_early(void);
diff --git a/arch/powerpc/platforms/pseries/hvconsole.c b/arch/powerpc/plat=
forms/pseries/hvconsole.c
index 1ac52963e08b..c40a82e49d59 100644
--- a/arch/powerpc/platforms/pseries/hvconsole.c
+++ b/arch/powerpc/platforms/pseries/hvconsole.c
@@ -52,7 +52,7 @@ EXPORT_SYMBOL(hvc_get_chars);
  *     firmware. Must be at least 16 bytes, even if count is less than 16.
  * @count: Send this number of characters.
  */
-int hvc_put_chars(uint32_t vtermno, const char *buf, int count)
+int hvc_put_chars(uint32_t vtermno, const char buf[16], int count)
 {
        unsigned long *lbuf =3D (unsigned long *) buf;
        long ret;
diff --git a/drivers/tty/hvc/hvc_vio.c b/drivers/tty/hvc/hvc_vio.c
index 736b230f5ec0..011b239a7e52 100644
--- a/drivers/tty/hvc/hvc_vio.c
+++ b/drivers/tty/hvc/hvc_vio.c
@@ -115,7 +115,7 @@ static int hvterm_raw_get_chars(uint32_t vtermno, char =
*buf, int count)
  *       you are sending fewer chars.
  * @count: number of chars to send.
  */
-static int hvterm_raw_put_chars(uint32_t vtermno, const char *buf, int cou=
nt)
+static int hvterm_raw_put_chars(uint32_t vtermno, const char buf[16], int =
count)
 {
        struct hvterm_priv *pv =3D hvterm_privs[vtermno];

