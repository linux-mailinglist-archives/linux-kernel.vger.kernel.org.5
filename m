Return-Path: <linux-kernel+bounces-81907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AFF867BEA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5722918B8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A52112F588;
	Mon, 26 Feb 2024 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fPMrFxJq"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6204712F39D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964834; cv=none; b=Ju/3t/KF57LDu7fGVOp2ZiaBZvFWk1dQqKSirmlk/LYB4ThyeIXfDJr0kIPngK5T1B3XjadhhpPBBLnEYdkGQszJubmpj+X1C1kmqASyYu/SrNmvnYhYfL8448H1/+GhN+bUGgjmkDszYGWO3iynT6HP5sQOWfzfyXQ1m/3JbkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964834; c=relaxed/simple;
	bh=hgg5DxWcutysCpqUUHh8v/N4DHIRdbJjnn4QuWFi+a0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WXm2LwyG8njpCABiC9a7UMVzFP73KbX0Oclapm45NaM6UhvtL4kNxFmf6svtj2YAipIqif5/HCwP6QuIZrCV0UBqkygcml8wnj1ZEagAR/Q2wNmqExQUAyf3tzuNmHGhnmq/fTWhHKtN/f6nFRQdRI7ReJnSAk42iNAMyN+0mCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fPMrFxJq; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-563f675be29so3421378a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1708964831; x=1709569631; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xt7ERXevLJGYpaKrRDOFaMyrgJxPIzGAxZZ08d5pb1c=;
        b=fPMrFxJqTYgGfbYrscUYdg0bm7xWuXIrqnYymqBsyGPhK6E1g48HOSNHKtDaMyY5rg
         2QDyy0YVUDmVIzQi7WApHXkCr1a97zSrruoJx+aTgmx/fm2ZJ4IFtGUDGF3G1I51lWh0
         Ybx+mPKkURmRtOcJrKmyH2rVDZD5Pn1LRhgjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708964831; x=1709569631;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xt7ERXevLJGYpaKrRDOFaMyrgJxPIzGAxZZ08d5pb1c=;
        b=Fq9yZU2TGIt3ujHX3zHB+Yb5RhTZPTKbkPrj4am/BX3s6kOEzBuqeVwuJ2qWSilirD
         tim0Gk9Vf65Zua1cLMuIXagthD3xPhrMxdtsXrQEOmuiuDoU0o4YUTNvaSBRSm3eptcN
         222xXPOCeVxSSy6aY8eVsvXyDgxpXllYmA7ZFlfFOXTD9fuwoc/iUhe/egfl2ShWmADM
         l2lQgu3hvgSdkK0xS+pplES9ZKgBTYAj5rTcg9FnEn7IvwGR0khkFNYYbnKHLHI63vus
         0Vz3+yA0CWh0hamUsaVoS3K5Yf9BcQyoHK5K7mtJO1PwfXEWyo0vQdJjqD1BtiLIqiz8
         Zsaw==
X-Forwarded-Encrypted: i=1; AJvYcCV9LnYeYtg1NCRinymyZ6Fidul4oYgfK5gU44xP/mZVpK4up2PQdsixqKyO4Kn8mYevK3lh+Jc0NmfxhOEbv7hMeNf1BfBU6GmHmLKa
X-Gm-Message-State: AOJu0YwK+xOAN0owDu1cOiOHjJhtROw+nl+7ZuP/Cm3XZD9P8dk7qqO/
	r+wGSxuqT8FpGwzmdYCijDVfcvy4BhUMTtGBxuirbsHQ2SdSWWBYdbcUjj7mFY6r/lqnYzJ3wIe
	+UKVUP47nnTtumNAjmBT9YThFV6fnB+GC8dv1
X-Google-Smtp-Source: AGHT+IFDS6q1SKpfDPGI2qy7jkya+Esrmj3Z3DRFwT+7omAf0QKwbTSu7yvY+RTAdCnax22uB1QQaInd2a3syjglMiU=
X-Received: by 2002:aa7:c455:0:b0:566:1e8c:78b4 with SMTP id
 n21-20020aa7c455000000b005661e8c78b4mr615524edr.25.1708964830498; Mon, 26 Feb
 2024 08:27:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226144911.1297336-1-aleksander.lobakin@intel.com>
In-Reply-To: <20240226144911.1297336-1-aleksander.lobakin@intel.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 26 Feb 2024 08:26:58 -0800
Message-ID: <CACKFLikoY8RXL6zAZWV1YQ23KZJDrsF44WpDUB0Bq3GYaq2GkA@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt_en: fix accessing vnic_info before
 allocating it
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Somnath Kotur <somnath.kotur@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000af96d106124b613e"

--000000000000af96d106124b613e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 6:51=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> bnxt_alloc_mem() dereferences ::vnic_info in the variable declaration
> block, but allocates it much later. As a result, the following crash
> happens on my setup:
>
>  BUG: kernel NULL pointer dereference, address: 0000000000000090
>  fbcon: Taking over console
>  #PF: supervisor write access in kernel mode
>  #PF: error_code (0x0002) - not-present page
>  PGD 12f382067 P4D 0
>  Oops: 8002 [#1] PREEMPT SMP NOPTI
>  CPU: 47 PID: 2516 Comm: NetworkManager Not tainted 6.8.0-rc5-libeth+ #49
>  Hardware name: Intel Corporation M50CYP2SBSTD/M58CYP2SBSTD, BIOS SE5C620=
86B.01.01.0088.2305172341 05/17/2023
>  RIP: 0010:bnxt_alloc_mem+0x1609/0x1910 [bnxt_en]
>  Code: 81 c8 48 83 c8 08 31 c9 e9 d7 fe ff ff c7 44 24 Oc 00 00 00 00 49 =
89 d5 e9 2d fe ff ff 41 89 c6 e9 88 00 00 00 48 8b 44 24 50 <80> 88 90 00 0=
0 00 Od 8b 43 74 a8 02 75 1e f6 83 14 02 00 00 80 74
>  RSP: 0018:ff3f25580f3432c8 EFLAGS: 00010246
>  RAX: 0000000000000000 RBX: ff15a5cfc45249e0 RCX: 0000002079777000
>  RDX: ff15a5dfb9767000 RSI: 0000000000000000 RDI: 0000000000000000
>  RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>  R10: ff15a5dfb9777000 R11: ffffff8000000000 R12: 0000000000000000
>  R13: 0000000000000000 R14: 0000000000000020 R15: ff15a5cfce34f540
>  FS:  000007fb9a160500(0000) GS:ff15a5dfbefc0000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CRO: 0000000080050033
>  CR2: 0000000000000090 CR3: 0000000109efc00Z CR4: 0000000000771ef0
>  DR0: 0000000000000000 DR1: 0000000000000000 DRZ: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  PKRU: 55555554
>
>  Call Trace:
>  <TASK>
>  ? __die_body+0x68/0xb0
>  ? page_fault_oops+0x3a6/0x400
>  ? exc_page_fault+0x7a/0x1b0
>  ? asm_exc_page_fault+0x26/8x30
>  ? bnxt_alloc_mem+0x1609/0x1910 [bnxt_en]
>  ? bnxt_alloc_mem+0x1389/8x1918 [bnxt_en]
>  _bnxt_open_nic+0x198/0xa50 [bnxt_en]
>  ? bnxt_hurm_if_change+0x287/0x3d0 [bnxt_en]
>  bnxt_open+0xeb/0x1b0 [bnxt_en]
>  _dev_open+0x12e/0x1f0
>  _dev_change_flags+0xb0/0x200
>  dev_change_flags+0x25/0x60
>  do_setlink+0x463/0x1260
>  ? sock_def_readable+0x14/0xc0
>  ? rtnl_getlink+0x4b9/0x590
>  ? _nla_validate_parse+0x91/0xfa0
>  rtnl_newlink+0xbac/0xe40
>  <...>
>
> Don't create a variable and dereference the first array member directly
> since it's used only once in the code.
>
> Fixes: ef4ee64e9990 ("bnxt_en: Define BNXT_VNIC_DEFAULT for the default v=
nic index")
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks.
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--000000000000af96d106124b613e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBy0JDklZ/KPPwHlwyZqjXUDUwgYoU2t
RVHCOIwNVgcnMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDIy
NjE2MjcxMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBV5S771mgCkOWGDPxAuzl3Ujt5SBz8DclcPVpVTPPp8obZxiEx
IZHTAxMiJmXUWC88tlqhlVZSRQA93aXvi3l8AZ80kXlk4RP1MdevKwH2XbeCdsAHdbB4AarMSp5Q
1m+LvaVibPnWByUmoMX6roKG8j3JN4XmUCeVh8YimqLBk3zmZw3+/J5W2V9+Rfrfr78oGrhZJaNP
bAeCyevSEc1PxoPsmbrj84aDHn/evRP1NrYSV+73XqPt/KJuQvQLPYQSM8jKkLw7SG4GWnghugqQ
DWgRfCqhMcLlcR98dSG2+lx/I0OrmDg1ByrdTtGn0Cd55QlQM4sf4FiFcZtrbrvM
--000000000000af96d106124b613e--

