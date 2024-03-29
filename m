Return-Path: <linux-kernel+bounces-124145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AFB8912FD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D3B1F227B5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300673FB8D;
	Fri, 29 Mar 2024 04:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FZSmuwnO"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7DA3B78B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 04:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711687666; cv=none; b=HJd+ZV7pKYA0c1R8NL61MnA+ahhNPJqT68jHAsOIKkjAl3Bwg6kkInbdsf4zm7jPIa5H9rwtogwb7/BFnNL9mwj58/YEuTRuUW2TXTiA5iETWLph5BSN71TnLqKNf0hlDp+xLaINXMVpwBi4UEHBi7D/Ru+lembkrST2kZf1nBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711687666; c=relaxed/simple;
	bh=VhgUFYM4ROxZOGasXpOIrA7DBBvzJuMj4VUaKbBIVOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GiZEN/FL7HKgSsJK4un9Hac6sMIbN/rFNZnesqaCeKGTZ8kBpzp41CF13T1roNVaOoRsVqkmE6QmGHji4jCpdwwX+FzZbqKbXbGDiK+3z3r1+SgCOg96Fv8rOppN8xwit0EHPCSPDyeogr/HzayyM2mC5qvC+wj6ohuo5cBv+4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FZSmuwnO; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d6fc3adaacso24018991fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 21:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711687662; x=1712292462; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vMAsZUFQ5FjENErH731Sx98IRpeOmFUYLqB3B8gSY+E=;
        b=FZSmuwnOZwr5RFCkTnezJtZbVB8I5rShQh3zyf8zKwSwKZa/z15luDBNAqAhQR6Ztp
         7yoNGogq11GwRwrKI7xL6gbYu6GhXAwW0OQvTTG7nKKbBzY0s6whvjmE6ux9ojGoywFl
         BFzGRW4Y+7D2WFRv9gDzwEIzDC0C+oUIrs0b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711687662; x=1712292462;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMAsZUFQ5FjENErH731Sx98IRpeOmFUYLqB3B8gSY+E=;
        b=gh+sINFZs43ykhVHhQ+grO01hK65e87kE4xldk4rysv25dliBmiMEtJv/ypCkUvw6I
         565BGMVwLv62M8X9dK0EJnPn2sDSU/tArTYhEHn9XZjvocS+uGDko8ZvFQfR7Hvdkzxp
         cZUSL/xeIzXKXxMDlEabLU1aoPJgxgtrs6cRx05grx/BWP+TgQAYkm1PcEET2dwNbpyK
         Y2/xOPRrYu1gcoL15fLCIY+xCOABOXHB5r6008EtCPUVDMup3gEUkT2c/ckXBUe4Y50k
         DLLNXJQI+a/HkMtcPQSerjxpGaDVXbH8j2W1ChmVBP9nqwr5+fYM/T9HrvPWIxMK4htx
         tmsA==
X-Forwarded-Encrypted: i=1; AJvYcCUtaknR9gG/mLCwtqG1viSw5oyn7rCKkajAMQ+h7Lf9p8K8Pe8uS6h4G7s0UwTb8ykGecMtGkzCJmd/tYPKEGJa/mK6CrHb4hMe8MWS
X-Gm-Message-State: AOJu0Yw42QPTw6SurOOVwncs1+Y//4OpL5S9IDIRCoxdEZ66w8ue6d7s
	NKwDOgUdO8qlu+HE4sbbZJ/r74uQaYwPCWDDTUE4i4oib9dRnPLxFaw71vtZRiq1Cg+bwPfjAAr
	tjSpPOX7UNgBVjLnhOf245q21ulkOZ/q5eJsn
X-Google-Smtp-Source: AGHT+IFeNuuPs7EsCFmYfjxfs4Z8gA3ZupyIj/6k5NcLGrEUEjeik3CnL96H7HewCJvVCrteFi36D6eaADuAo2W0tKE=
X-Received: by 2002:a05:651c:1043:b0:2d4:6bab:eafe with SMTP id
 x3-20020a05651c104300b002d46babeafemr632587ljm.48.1711687662255; Thu, 28 Mar
 2024 21:47:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327075733.8967-1-ivecera@redhat.com> <20240327075733.8967-4-ivecera@redhat.com>
In-Reply-To: <20240327075733.8967-4-ivecera@redhat.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Fri, 29 Mar 2024 10:17:29 +0530
Message-ID: <CAH-L+nPRUoC-f=k9CUZXjKnAcTV7L4fgkDOnK7dQ9DCeZBMMmA@mail.gmail.com>
Subject: Re: [PATCH iwl-next v2 3/7] i40e: Refactor argument of i40e_detect_recover_hung()
To: Ivan Vecera <ivecera@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mschmidt@redhat.com, 
	aleksandr.loktionov@intel.com, jesse.brandeburg@intel.com, 
	anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000018fa8b0614c557b9"

--00000000000018fa8b0614c557b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 1:28=E2=80=AFPM Ivan Vecera <ivecera@redhat.com> wr=
ote:
>
> Commit 07d44190a389 ("i40e/i40evf: Detect and recover hung queue
> scenario") changes i40e_detect_recover_hung() argument type from
> i40e_pf* to i40e_vsi* to be shareable by both i40e and i40evf.
> Because the i40evf does not exist anymore and the function is
> exclusively used by i40e we can revert this change.
>
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 10 ++++++----
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h |  2 +-
>  3 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/et=
hernet/intel/i40e/i40e_main.c
> index 7fed7fb69d4e..1ba28893f49e 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -11274,7 +11274,7 @@ static void i40e_service_task(struct work_struct =
*work)
>                 return;
>
>         if (!test_bit(__I40E_RECOVERY_MODE, pf->state)) {
> -               i40e_detect_recover_hung(pf->vsi[pf->lan_vsi]);
> +               i40e_detect_recover_hung(pf);
>                 i40e_sync_filters_subtask(pf);
>                 i40e_reset_subtask(pf);
>                 i40e_handle_mdd_event(pf);
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/et=
hernet/intel/i40e/i40e_txrx.c
> index 1a12b732818e..e35a08de16b2 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -860,13 +860,15 @@ u32 i40e_get_tx_pending(struct i40e_ring *ring, boo=
l in_sw)
>
>  /**
>   * i40e_detect_recover_hung - Function to detect and recover hung_queues
> - * @vsi:  pointer to vsi struct with tx queues
> + * @pf: pointer to PF struct
>   *
> - * VSI has netdev and netdev has TX queues. This function is to check ea=
ch of
> - * those TX queues if they are hung, trigger recovery by issuing SW inte=
rrupt.
> + * LAN VSI has netdev and netdev has TX queues. This function is to chec=
k
> + * each of those TX queues if they are hung, trigger recovery by issuing
> + * SW interrupt.
>   **/
> -void i40e_detect_recover_hung(struct i40e_vsi *vsi)
> +void i40e_detect_recover_hung(struct i40e_pf *pf)
>  {
> +       struct i40e_vsi *vsi =3D pf->vsi[pf->lan_vsi];
>         struct i40e_ring *tx_ring =3D NULL;
>         struct net_device *netdev;
>         unsigned int i;
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/et=
hernet/intel/i40e/i40e_txrx.h
> index 2cdc7de6301c..7c26c9a2bf65 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> @@ -470,7 +470,7 @@ void i40e_free_rx_resources(struct i40e_ring *rx_ring=
);
>  int i40e_napi_poll(struct napi_struct *napi, int budget);
>  void i40e_force_wb(struct i40e_vsi *vsi, struct i40e_q_vector *q_vector)=
;
>  u32 i40e_get_tx_pending(struct i40e_ring *ring, bool in_sw);
> -void i40e_detect_recover_hung(struct i40e_vsi *vsi);
> +void i40e_detect_recover_hung(struct i40e_pf *pf);
>  int __i40e_maybe_stop_tx(struct i40e_ring *tx_ring, int size);
>  bool __i40e_chk_linearize(struct sk_buff *skb);
>  int i40e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **fram=
es,
> --
> 2.43.0
>
>


--=20
Regards,
Kalesh A P

--00000000000018fa8b0614c557b9
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQiwYJKoZIhvcNAQcCoIIQfDCCEHgCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3iMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEIIwZQpkskOkDmaYkSyWdBTYqIZmuts6EQOgJNzZhKVIVMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMyOTA0NDc0MlowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA0UWs2v670
sAyvM3s0brf0C5x4GGgc28u7II32v8crkLRPtS1m8gd8kPcSQ7r/UOImMaVpYgNJHNhNpVgMtMBT
66t4D/jLPdbYF6BlcTYZRr9JPudyQ/NxBd2EI7CznjLcRV9ZLRpLCcppDTyLnLsxakeYwniwpe1G
8nkKlqgBVLptqbEKArO3ItT8nEqvVattspKgu5CStYazqSXm+VOmWpiXp71yUj8ZvPcvHehcE4B9
+i3gZQeFDQCSdU0mRkidPw9r9NdhZwJ/JwWSy/4pKfhvm7DTehKepIu0OquKOqMbmDDE+XRB1UG1
LfsC22kzplpSH8vPwl83Gx/rflv8
--00000000000018fa8b0614c557b9--

