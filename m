Return-Path: <linux-kernel+bounces-119390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D763288C81A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06EB51C643AA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB13913CA87;
	Tue, 26 Mar 2024 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cgqJ1/He"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFE313C8ED
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711468227; cv=none; b=ZSyo339RVxiHnGFmE2C27ffb48WE0IHJcUWu35kfeFOPhx/iBUn9OsLKjkZfND2Z+Tw+8RERtGFNdPXDQMtVa5GSH17W577beethtVLaKPhQgkXFSTIEcLx0D4CGliEig4gYKGUZalJpeHhSM7wf+2wyUVSJWGODLvqMaftBukM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711468227; c=relaxed/simple;
	bh=jaTbuGAl34e3aK2WEZrjL9jrBqbdAV2FFXAHmLTBV8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNiHONnRUGL/wX6WB7QOZ2ATfzYjent4Mibj9xLGXg26BTE7nk5Ma/uJKgkN1qTVnt092BJRq/6lqRlzKCLcOd+Iq4UoE65bcJys2QzLO3zkY/vNh+40fpn5xQ8WbAmXdReo+sPv5rrjWS679Ga9RQxareSgwxIkIHXYhQ6n/Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cgqJ1/He; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513edc88d3cso6260791e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711468224; x=1712073024; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TtSJkBJlUT+s4IFFoGRYtvw9Qzhu545c4HEyZzlKRpc=;
        b=cgqJ1/He/mX6J2MwoYqWHd/ZEtAjikcgpIRfbz75PR6Dbv/Cwf0Q4eF4L4R/sPQDtD
         ruMVY8fy5ETyxCa3uVGmBELhJhJQ55AiUQ0vGQGugoU63F4co3zf0SnpOyLKBZKGNZne
         IXbsP/uFmp5UfuLSfVnX+xViNS8QFG6+JmKN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711468224; x=1712073024;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TtSJkBJlUT+s4IFFoGRYtvw9Qzhu545c4HEyZzlKRpc=;
        b=Omfowdt0Ukn2Sct2uVpPjbt029GR8pnK+8ox1bihQkyY+gk++oBhfZx9M5vUfGAdsl
         ut86767ZUvF9LRxtqjG2XOZibEx4/UVX7L5O8nubVTTMwGE0dC5Tdn3asJZQ9QYWNUVh
         8R4IgApB/C8DTnmGxjsQNXWgzKgnd5kG9AKOzEpXqrHouEpBN8fwH09KoNP6VWseifzv
         E01xwFQ9X8N9magZD9gdOvDPiPquRxzzFfsehKYLevG2jAWxDP8rJjq9IreUtn+beFcV
         7piyOjTgr3rdJzEe11F96fneZsOYfHQMxJ9Jn41SGNOH1EAlbFDrtP20ZwpuZsAwMnTq
         C4rQ==
X-Forwarded-Encrypted: i=1; AJvYcCW43NQhRc3sfJx9NniXpo04p1zLpi36I9/OfUE8hiUwte83N9pO2X1DlzHsEOs6nKDxS0ofnTJ2pKQFQdrkHoj+a9sph9XGz8CstyO0
X-Gm-Message-State: AOJu0YwOESmUOYsYGSePNeTiMJjRH2A3AXfAcrTqYyLjaeM/rtmF/Evk
	/CMHKpNwwiUaeDJa7jpKB5mziWGF/CfAxlX0bGx9eq4yPVSkj2GX1EwTb9maapv8i9FqH4KozXG
	qfkmpNNgQGlX2HXdU8ns5tumCeqA7iIjpcBEu
X-Google-Smtp-Source: AGHT+IEZsWWhyJnpVY4bOEB1rkwgNZ4QLyZCmfdVyz38U6YTYA3uMIazxxrn5hR1yshvHc+fDrlCli7x096SWH2PV/8=
X-Received: by 2002:ac2:464e:0:b0:515:a8c9:6ec4 with SMTP id
 s14-20020ac2464e000000b00515a8c96ec4mr1326729lfo.42.1711468223601; Tue, 26
 Mar 2024 08:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318143058.287014-1-ivecera@redhat.com> <20240318143058.287014-2-ivecera@redhat.com>
In-Reply-To: <20240318143058.287014-2-ivecera@redhat.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 26 Mar 2024 21:20:10 +0530
Message-ID: <CAH-L+nPvsC=ZKgR-pFOYYFZ1+G4DgPW=oTaAOyDJJY-vMjbJBQ@mail.gmail.com>
Subject: Re: [PATCH iwl-next 1/7] i40e: Remove flags field from i40e_veb
To: Ivan Vecera <ivecera@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008b41e50614923f66"

--0000000000008b41e50614923f66
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 8:01=E2=80=AFPM Ivan Vecera <ivecera@redhat.com> wr=
ote:
>
> The field is initialized always to zero and it is never read.
> Remove it.
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
LGTM
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

>  drivers/net/ethernet/intel/i40e/i40e.h         |  3 +--
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 13 +++++--------
>  3 files changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/etherne=
t/intel/i40e/i40e.h
> index 2fbabcdb5bb5..5248e78f7849 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -788,7 +788,6 @@ struct i40e_veb {
>         u16 stats_idx;          /* index of VEB parent */
>         u8  enabled_tc;
>         u16 bridge_mode;        /* Bridge Mode (VEB/VEPA) */
> -       u16 flags;
>         u16 bw_limit;
>         u8  bw_max_quanta;
>         bool is_abs_credits;
> @@ -1213,7 +1212,7 @@ void i40e_vsi_stop_rings(struct i40e_vsi *vsi);
>  void i40e_vsi_stop_rings_no_wait(struct  i40e_vsi *vsi);
>  int i40e_vsi_wait_queues_disabled(struct i40e_vsi *vsi);
>  int i40e_reconfig_rss_queues(struct i40e_pf *pf, int queue_count);
> -struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags, u16 uplin=
k_seid,
> +struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 uplink_seid,
>                                 u16 downlink_seid, u8 enabled_tc);
>  void i40e_veb_release(struct i40e_veb *veb);
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net=
/ethernet/intel/i40e/i40e_debugfs.c
> index f9ba45f596c9..6147c5f128e8 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> @@ -867,7 +867,7 @@ static ssize_t i40e_dbg_command_write(struct file *fi=
lp,
>                         goto command_write_done;
>                 }
>
> -               veb =3D i40e_veb_setup(pf, 0, uplink_seid, vsi_seid, enab=
led_tc);
> +               veb =3D i40e_veb_setup(pf, uplink_seid, vsi_seid, enabled=
_tc);
>                 if (veb)
>                         dev_info(&pf->pdev->dev, "added relay %d\n", veb-=
>seid);
>                 else
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/et=
hernet/intel/i40e/i40e_main.c
> index 663b2237eb4e..2f1604ae78c7 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -13138,7 +13138,7 @@ static int i40e_ndo_bridge_setlink(struct net_dev=
ice *dev,
>
>                 /* Insert a new HW bridge */
>                 if (!veb) {
> -                       veb =3D i40e_veb_setup(pf, 0, vsi->uplink_seid, v=
si->seid,
> +                       veb =3D i40e_veb_setup(pf, vsi->uplink_seid, vsi-=
>seid,
>                                              vsi->tc_config.enabled_tc);
>                         if (veb) {
>                                 veb->bridge_mode =3D mode;
> @@ -14394,10 +14394,10 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf =
*pf, u8 type,
>                 }
>
>                 if (vsi->uplink_seid =3D=3D pf->mac_seid)
> -                       veb =3D i40e_veb_setup(pf, 0, pf->mac_seid, vsi->=
seid,
> +                       veb =3D i40e_veb_setup(pf, pf->mac_seid, vsi->sei=
d,
>                                              vsi->tc_config.enabled_tc);
>                 else if ((vsi->flags & I40E_VSI_FLAG_VEB_OWNER) =3D=3D 0)
> -                       veb =3D i40e_veb_setup(pf, 0, vsi->uplink_seid, v=
si->seid,
> +                       veb =3D i40e_veb_setup(pf, vsi->uplink_seid, vsi-=
>seid,
>                                              vsi->tc_config.enabled_tc);
>                 if (veb) {
>                         if (vsi->seid !=3D pf->vsi[pf->lan_vsi]->seid) {
> @@ -14791,7 +14791,6 @@ static int i40e_add_veb(struct i40e_veb *veb, str=
uct i40e_vsi *vsi)
>  /**
>   * i40e_veb_setup - Set up a VEB
>   * @pf: board private structure
> - * @flags: VEB setup flags
>   * @uplink_seid: the switch element to link to
>   * @vsi_seid: the initial VSI seid
>   * @enabled_tc: Enabled TC bit-map
> @@ -14804,9 +14803,8 @@ static int i40e_add_veb(struct i40e_veb *veb, str=
uct i40e_vsi *vsi)
>   * Returns pointer to the successfully allocated VEB sw struct on
>   * success, otherwise returns NULL on failure.
>   **/
> -struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
> -                               u16 uplink_seid, u16 vsi_seid,
> -                               u8 enabled_tc)
> +struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 uplink_seid,
> +                               u16 vsi_seid, u8 enabled_tc)
>  {
>         struct i40e_vsi *vsi =3D NULL;
>         struct i40e_veb *veb;
> @@ -14837,7 +14835,6 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *p=
f, u16 flags,
>         if (veb_idx < 0)
>                 goto err_alloc;
>         veb =3D pf->veb[veb_idx];
> -       veb->flags =3D flags;
>         veb->uplink_seid =3D uplink_seid;
>         veb->enabled_tc =3D (enabled_tc ? enabled_tc : 0x1);
>
> --
> 2.43.0
>
>


--=20
Regards,
Kalesh A P

--0000000000008b41e50614923f66
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
AQkEMSIEIKcFSDrIi/ib7jpqphSFrLwQBwFxlaZBL28xHk6P8Jf2MBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMyNjE1NTAyNFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCWSeEjRpjV
+tKWmNzFYmFPpliKQz/7SEWO8nljpg7bGN5dR9FyENmt85Ih+40BDAGmkWVBhdKQAXMfZ50+xDdS
Hl9Zmfz5XzDvBWfJvgZI+JsVIfjYs2yqb4f3mwwgYjylWip4KjzlhokMP8E96gTYCcjoJ0Z8XOab
YJXPLGlCnsDXuFJ563hncanrKdC+MUao3KrGigSmb4B6l99HPiRfnHFRX758JL53QWznj8uVVFHT
cNG6hhaxxDgTLHMbmlw3eiRZwCnrVyexNFmNlSJPFIUt/6G6DXVvsWZ+lYykL4fic8Pw+IMmDQrB
kjHqAvQpA4JDR8IzztYxMV4kAJuA
--0000000000008b41e50614923f66--

