Return-Path: <linux-kernel+bounces-91094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 562EE870986
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 216A3B294A5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6612F626C4;
	Mon,  4 Mar 2024 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AXUpl2za"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BE262170
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709576759; cv=none; b=IuSA0GRwNlrJE8WOg/KTF98K1zgfpij1H+6irv3pip7i6/3TKg4sPmMUS0PbAKoexRTZU7bb9LkbqGPA44p0u4WYE26L+nJn69b5d/czUh7WG89ZHOp/EZ92c5HJNCGu7maec5bYg6GkFfoDc5Avu6YmzsxEqQTON2kASdPrWpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709576759; c=relaxed/simple;
	bh=p0slENr/LhOjdxk/ZgQPn4HnE8msvkV5FJP7/p5Po84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KY8MuAdXdFvoFEy2aGIvv9DwXWiyIIiS5RjsH0N5y5VyffNwJgqh2ZtK5lolp0iySLDOJZHPQJlylMkQak2Xa7If9o5SeWZRv7bu2IDgDcsKIwAfCrEq8ClFncmcpTd1O35ERD6SQg54LJND/Kl4sFfryP4mEdNgpsAYa3VVIHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AXUpl2za; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-563b7b3e3ecso7326919a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 10:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1709576755; x=1710181555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DJVlKk2+3ntgQ2W9sV6kT3VosvM1495yR92apgIpSJU=;
        b=AXUpl2zajqJYzi8hu84fKyi6gyRzAOCNcXuwYwxH5Z5jEhAveaJAUjT1K1o55upN74
         RTtUQm6jIfReMUfhzwUPqPSZgkqewPiBJgbjt49y6APk4GMd+m0EJc4DKw9MjYyGvO8c
         RG2yVXvEueXedGDvOTI6Lgvc2Fgqi1sBnQUBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709576755; x=1710181555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJVlKk2+3ntgQ2W9sV6kT3VosvM1495yR92apgIpSJU=;
        b=toktaEAwok8BaugLFMnZZRM2mbirVVwdBs85VXV55i2Ptvg1n5YyfLmXPluSN8r1rN
         tO1+1DVFRYitH1M2alhtZoEmgZA7+DeQBFhRphcCT5yXEHc3O9McQ5yvHV15Kp8vVmpl
         oQAn49gtozic51MupkJf/KVqPvgI/L3EyQYX2iNWdyzSoRAc0+AZZT1EwvwkSQEMiXzL
         VGh7o/msXNEhnTTHhtDHz9nHn0s1CDP/95qzfj7eqrVzfXqCUGZm7cginZ7d8p1ERlW+
         AuKChnEpFim6XVEFGMlytVxSQ7kOCCSBd8sdHDYnSSg587wYf86wYoa2uBx+QMyAPogL
         YrOg==
X-Forwarded-Encrypted: i=1; AJvYcCXiV7hUVFp7MiMNaomXWQnt4yzp5wyX4XOW10CdazJoeRZ1xzK3qvxYE2NflEpj1JOzEpEhaO15ex+mOaBmN3QjDsgRKRS20rdIq8ug
X-Gm-Message-State: AOJu0YxfE82iK7IUb6Tp4jBB8mGRTB+aG/VUXNqutwyv90bmrkMAEL92
	+kNi7OFrug393FfFX5y9cqxfIvBakI+VwX/URy8oIVeilsP2GBAFCxMFGaINFOlQhSSaRWOtd4f
	x7FXmp3UdhGTAZMFkKA34v9nqnTA5MUmNcfHmmNivmUtm/IROz9yfgws4kjU/c1+eiLnsXWcONm
	69G4UuRbjM/jLPtv+jteYOEmZToA==
X-Google-Smtp-Source: AGHT+IEOiuQ/Pi8xWYePCFTWwA6wYJfsezjbCGifitR4itjrA5S+bF4BmvreAIT9jSUUP8d/NnYLUu1vaThaW5wPPkQ=
X-Received: by 2002:a17:907:986e:b0:a45:871e:7dc9 with SMTP id
 ko14-20020a170907986e00b00a45871e7dc9mr895514ejc.1.1709576755113; Mon, 04 Mar
 2024 10:25:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304091119.847060-1-usama.anjum@collabora.com>
In-Reply-To: <20240304091119.847060-1-usama.anjum@collabora.com>
From: Justin Tee <justin.tee@broadcom.com>
Date: Mon, 4 Mar 2024 10:25:43 -0800
Message-ID: <CAAmqgVNbMkPmFGB9rYyNKPO68zbgGYevyLsv-yZuiTu6t+23jg@mail.gmail.com>
Subject: Re: [PATCH v2] scsi: lpfc: correct size for cmdwqe/rspwqe for memset
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: James Smart <james.smart@broadcom.com>, Dick Kennedy <dick.kennedy@broadcom.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, kernel@collabora.com, 
	kernel-janitors@vger.kernel.org, James Smart <jsmart2021@gmail.com>, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003b071a0612d9db68"

--0000000000003b071a0612d9db68
Content-Type: text/plain; charset="UTF-8"

> The cmdwqe and rspwqe are of type lpfc_wqe128. They should be memset
> with the same type.
>
> Fixes: 61910d6a5243 ("scsi: lpfc: SLI path split: Refactor CT paths")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Use *ptr instead of specifying type in sizeof
> ---
>  drivers/scsi/lpfc/lpfc_bsg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
> index d80e6e81053b0..7d5275d3a7406 100644
> --- a/drivers/scsi/lpfc/lpfc_bsg.c
> +++ b/drivers/scsi/lpfc/lpfc_bsg.c
> @@ -3169,10 +3169,10 @@ lpfc_bsg_diag_loopback_run(struct bsg_job *job)
>         }
>
>         cmdwqe = &cmdiocbq->wqe;
> -       memset(cmdwqe, 0, sizeof(union lpfc_wqe));
> +       memset(cmdwqe, 0, sizeof(*cmdwqe));
>         if (phba->sli_rev < LPFC_SLI_REV4) {
>                 rspwqe = &rspiocbq->wqe;
> -               memset(rspwqe, 0, sizeof(union lpfc_wqe));
> +               memset(rspwqe, 0, sizeof(*rspwqe));
>         }
>
>         INIT_LIST_HEAD(&head);
> --
> 2.39.2
>

Reviewed-by: Justin Tee <justin.tee@broadcom.com>

-- 
This electronic communication and the information and any files transmitted 
with it, or attached to it, are confidential and are intended solely for 
the use of the individual or entity to whom it is addressed and may contain 
information that is confidential, legally privileged, protected by privacy 
laws, or otherwise restricted from disclosure to anyone else. If you are 
not the intended recipient or the person responsible for delivering the 
e-mail to the intended recipient, you are hereby notified that any use, 
copying, distributing, dissemination, forwarding, printing, or copying of 
this e-mail is strictly prohibited. If you received this e-mail in error, 
please return the e-mail to the sender, delete it from your computer, and 
destroy any printed copy of it.

--0000000000003b071a0612d9db68
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
QsyUohclvlxgt5d/MsBG6WZxZ+uppzNvjEk/wUu+6JQNUVEMviA6eBCCi+4ShjZUbGPES11h5lw/
wuyQZDIjy+1hGPtLHBXI/QQEbU3OVdTRn+aEMwIDAQABo4IB2DCCAdQwDgYDVR0PAQH/BAQDAgWg
MIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVo
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNV
HSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2ln
bi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAiBgNVHREEGzAZ
gRdqdXN0aW4udGVlQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAW
gBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUlHfvnuNaLp52RO2Y2En9J+7MKI4wDQYJ
KoZIhvcNAQELBQADggEBAGaBsEmLZwejb3YsmigadLZGto3hJ7Erq2YZLhL7Pgtxft1/j4JNLsRN
t3ZJIW2Xzfbj0p328xRekSP1gjZ9Szre0fxEFXH1sS1a7WP9E0fHxVW07xVsxGxo5opAh5Gf/bQH
S4x9pCO48FJI310L1RGQiqFKY/OECnXO821y8MAyObbGo9HNHP4Sk6F5J1v2qJzbLtMfj8ybbTGe
SidstRgjOIqMldZs2Koio14QFE7hJY+8KRiKfq+eb1EwQTMzBxZsMOL5vUSZjYg2+Fqwyr6YYp0w
Lsq/wH9o18xSvL/FikpG4JRxiT20RdM6DQrk9lv8ijASZCuN3JR61WUNz2AxggJtMIICaQIBATBr
MFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9i
YWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwMd6BsMSBDsagVFtYwDQYJYIZI
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOVj6F/Sp/Hrdccw+ckhf/FMwUyB8EuSvcCk0SDx
s2I5MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMwNDE4MjU1
NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQBpXxFL5rthmIHJyyM4rFhpd3DStfJh1IF/EY55PoS+hi0dRsl/1s3PTWZ1
+ZZAU06anwEZhVvgd8yYBRPQfvBVH1pWeXhshvBx1d4SftZITEz7JdEMRwFq8f1vExhk6QSHfkG2
oNDY6amfy9Cfpo3kTqIG/VXC3SYLQwEsuumGzG1Nge2i+uxotNLeZGttqh7OWLlIzEfSvVI0uuII
sVPdNTtPdPCQRVhFSokIUljXNuhwaG3T5tYY0qvOL76Q02EyiNSmGzousCs9hfVCp3MwbFHHSlve
ioeBeXWHz4TxawGMxhxa7rgufxwVGG058dz84tk9KQUY+nF9xY4IT0Pf
--0000000000003b071a0612d9db68--

