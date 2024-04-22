Return-Path: <linux-kernel+bounces-153796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 209368AD343
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62EF1F21833
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C75153BF5;
	Mon, 22 Apr 2024 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gHQbum2t"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF04C153BE1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713806495; cv=none; b=MGU7gh5wb5L23S0tfDnxYwrdEGRxbGPMM/pEXF7WSDTxW/4DQrKwq3NUv3GcMu/mduElonKwPHBPhcqb7fhUWntdjpqUSNEIcI9DzVzHCsnlwcFnKYIC3EN9yu/sq6z3TPaYwlRsDyEAD9dzUEc1PMSmtshxOW+vfjIyRmdv9i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713806495; c=relaxed/simple;
	bh=vlqA1fBJDvLVrpPxkJhQEkoSULbpXOLTNNMAGaGnPsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdsGb4u7cuQr+o+b/KkChQvY7BkMefYg2w9ne6n/BL8oTOBv/C57KpTzd0LBDmrufu/RVoFPwBaUWRTtku+fkwLzqEM9vSo8QQFhEQdUFUtI4j2QiFs9oFtp5tipG0iQs/RQpWSZ3CrsfvO64b/bf9DIvztv4AKrHRJu+6yLGgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gHQbum2t; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6150670d372so42051907b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1713806493; x=1714411293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=46PbGYVyS6vRtQF98S3XnuIdUSX2r0I5JNRdx7ADc2M=;
        b=gHQbum2t8E+LIQX7xewNNXcar9rXfjTbe7strrjLvrvRTwIbwp9CixDXEJ0e5xrhBi
         hSIVwoXWIU0s+2sk/jUvDwmx0hoBvD86nM2g9euq4ZuzaSH20i877/Q5NUtj0zwiOvZ7
         RfxpcmoQOaVSObq9iOHx+y/c3tj0qz5eyGgAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713806493; x=1714411293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46PbGYVyS6vRtQF98S3XnuIdUSX2r0I5JNRdx7ADc2M=;
        b=U6bSsnrfoxNFwcAix0mY+6MY764a3RHQcJgA0EVNeHsnBlPTn2hjuZyMJUz5QrAo+Q
         dcoh6loYImfWiKbC+HH5S+/0U+Pz1y8b6QNC6lNQ/RVpQVvvggD/iN4aU6ZTEdKEi6uG
         56Aal75w5CdRsF6SBkIBcv36Etc+E7uUiQEWXaZrywn3ceCt1e1CKn1P9raZmrJmgBoy
         PLCTOj54IGSLzFd61HbyOAIissX7+YYWSn/HstDy0GX1qjgt9Q9ltl+Qh4OqiaWh+vzS
         VV9oaHN6IOUeKzJtLRvT/+Kuyf+bGckkV6NfQX0WRNZO58PICnS1KOIbRqs+XUVVY7Q+
         ojxg==
X-Forwarded-Encrypted: i=1; AJvYcCUHKhApturBLYNLIpfhNYgW4/vZTycIxFXgW8jtfZQH+a5KFqt4CuT0dPVf7cZ0thJ5xDjUCHRclydujxf3KArAixBZCaNth05Jqzz9
X-Gm-Message-State: AOJu0YwqYCIOhLNnkEoR7z5xyEEy9pvyd7jJQMrtWv3/3DOVGT32XTjw
	yS7cFVHMBQ9gjIGlsT5xq/z5O4IRXmLR3n5+0MqdzvFwyb+QJfEYWMwLtXxXGfJlQbLPj2zFtAk
	mW3mQvEaaALFeHYa3GrLY3Oy8s3ByK8mRiR6E
X-Google-Smtp-Source: AGHT+IHdyiJxhnXVP7eDowRV/IGoJbK3MUOQvarP0xxCGMZdBSHN0yhyiHQ246x4kivH7MExvjzGzPjJLYdhCBe9xgY=
X-Received: by 2002:a05:690c:6f85:b0:618:1ce6:b618 with SMTP id
 je5-20020a05690c6f8500b006181ce6b618mr11509487ywb.12.1713806492739; Mon, 22
 Apr 2024 10:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422152626.175569-1-ast@fiberby.net>
In-Reply-To: <20240422152626.175569-1-ast@fiberby.net>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Mon, 22 Apr 2024 22:51:21 +0530
Message-ID: <CAHHeUGWsz=fhTSqnNiTphB5TRcf4ZyNsEov+vqtUEBiT+XCEag@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt_en: flower: validate control flags
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michael Chan <michael.chan@broadcom.com>, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003e6c760616b2abd1"

--0000000000003e6c760616b2abd1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 8:58=E2=80=AFPM Asbj=C3=B8rn Sloth T=C3=B8nnesen <a=
st@fiberby.net> wrote:
>
> This driver currently doesn't support any control flags.
>
> Use flow_rule_match_has_control_flags() to check for control flags,
> such as can be set through `tc flower ... ip_flags frag`.
>
> In case any control flags are masked, flow_rule_match_has_control_flags()
> sets a NL extended error message, and we return -EOPNOTSUPP.
>
> Only compile-tested.
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/e=
thernet/broadcom/bnxt/bnxt_tc.c
> index 273c9ba48f09..d2ca90407cce 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
> @@ -370,6 +370,7 @@ static int bnxt_tc_parse_flow(struct bnxt *bp,
>                               struct bnxt_tc_flow *flow)
>  {
>         struct flow_rule *rule =3D flow_cls_offload_flow_rule(tc_flow_cmd=
);
> +       struct netlink_ext_ack *extack =3D tc_flow_cmd->common.extack;
>         struct flow_dissector *dissector =3D rule->match.dissector;
>
>         /* KEY_CONTROL and KEY_BASIC are needed for forming a meaningful =
key */
> @@ -380,6 +381,9 @@ static int bnxt_tc_parse_flow(struct bnxt *bp,
>                 return -EOPNOTSUPP;
>         }
>
> +       if (flow_rule_match_has_control_flags(rule, extack))
> +               return -EOPNOTSUPP;
> +
>         if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
>                 struct flow_match_basic match;
>
> --
> 2.43.0
>
>

Thanks for this fix, it looks good. I need some time to test this; I
will get back to you in a few days.
-Harsha

--0000000000003e6c760616b2abd1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWcwggRPoAMCAQICDAGseBnUOryiK+cWfTANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODE3MzRaFw0yNTA5MTAwODE3MzRaMIGg
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHjAcBgNVBAMTFVNyaWhhcnNoYSBCYXNhdmFwYXRuYTExMC8G
CSqGSIb3DQEJARYic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJyb2FkY29tLmNvbTCCASIwDQYJKoZI
hvcNAQEBBQADggEPADCCAQoCggEBANGVy7il6qkWFiW5c4+kohP7xrKuKgQsfDqhhdfOx4FvPMTF
A9S2FwTdDOPuDNiSdR2+KK3JzqRLtBCSHV80dlEzwnOgLnlKkFQZvASsdXFtP9j56nc/ni7V4q9G
Ob5RVSl61kWgHXVmZYj+SqUEKdNy1opV5mitkOJHa9zhftMojx+ylauLeBDp7lEjgg5xFPme6KGV
GkD3dAbV6M4mQWaR6RpcUU4Jk+Og3FCDkG8PIxRKia+tBqfj2IGoR9LIlX8WZ/hhHTmkkwnsfr59
kjjPMh9o02jAvOzf/CLmWENkxup5gyPmlM8xAVlqZmn0EtlzxEg2YqBHkRb1s1NNPi0CAwEAAaOC
AeMwggHfMA4GA1UdDwEB/wQEAwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0
dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2Ey
MDIwLmNydDBBBggrBgEFBQcwAYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3Bl
cnNvbmFsc2lnbjJjYTIwMjAwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEW
Jmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0f
BEIwQDA+oDygOoY4aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMC5jcmwwLQYDVR0RBCYwJIEic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJyb2FkY29tLmNv
bTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAd
BgNVHQ4EFgQUXHovQBXsYr3/QkkF+EruxqF3ajswDQYJKoZIhvcNAQELBQADggEBAKHfsxL3xirL
i7ilaAfW67MeZRrOqvgw4nXhuj+QzkDDZ4QCb6IEYs1B783CbRNC0Vohjtesr+GKJyeTTRqP/Ca2
tPHjp5VJ3mZZ7Vu1Gnwj5kicRlSs3p7UVzpstr/cGn3oRz4Pby+VIbPftHCyUdrUOocITnz17hmR
JryVxNcbPcjGdGhThv3mdEDg2RCrFR1X0jlSAsLbQn83Agls1OHzBPHuudbspjj3/jJGD8gsIcnx
dgaqC7WHdB3zZutGigdpsmj/fxrvqbTUW8ZakCTtc8C57oDCeoBI4L+KAaFoHOJjVlWaQ3g9Fefa
eiXd6ovtpOAc/1MAXvMftuX+mQIxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNp
Z24gMiBDQSAyMDIwAgwBrHgZ1Dq8oivnFn0wDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkE
MSIEICy6fcF/Y1QODUaHjshUScHKgHYtluKpo3xIPACMRwdaMBgGCSqGSIb3DQEJAzELBgkqhkiG
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQyMjE3MjEzM1owaQYJKoZIhvcNAQkPMVwwWjALBglg
hkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0B
AQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAfhKfgeuF+1OVD
1OVPVV4HSg0Qe8Kv0+BwLcKG+BX+1cw3icFit1JHcGkUg8p2hRuHMAd4wTynY5XYdYS42vX+ZzMc
qh7N2yMq08Ljt2gon6bYUXy0l2JObkoDEmoY5xRcsoL8fv4xFUkykNp5P8Byu+Pc15U896UPuI2R
b5dIFma3I3bG+XSG/DHhGN6inyWdjHrV7ALHfU/ulqZq9+cqSlmAtul5xB/00jEEWtPyDSDgIF8s
syqq5px+aCPP9LYrvMywRM0HKC80962rEojz+URMI9wZOZcRGJIcOrEZ0262/WrSANxlw6GkwFYD
fO7Pt+UU6HArGExxVVuwcMGg
--0000000000003e6c760616b2abd1--

