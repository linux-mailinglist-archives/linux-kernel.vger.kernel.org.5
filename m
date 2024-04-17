Return-Path: <linux-kernel+bounces-147924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF848A7B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4341C1C2102A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624FE79C2;
	Wed, 17 Apr 2024 04:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hgST/QMR"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7FD8475
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 04:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713328103; cv=none; b=aXn7JVq2Yzirjq8hGwOglxX1EA3P64VLFfbYQb68eZOwOxsZLUIrRCABX8/nis3g+vmvqbwYU2JV7ataXm9geXV7ol5G8kTEXi86kLkP4xCS6CIkkFM68kya15YvFSD2xSe8bsl/NPCPWidCIPvRtvaTTR+sWmgkdRdp5FPIghw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713328103; c=relaxed/simple;
	bh=DpzN8aZqDIXwJ8lLm0pzidyzjiajmv/3QecbvayvlKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejaiK6V7P+eUMK39+HP0vKCh/zTtSikDQorNlzCy7c3Mc//U0zBjv4KEj3eXZtPL0QGILhsnbQN3+J+UnnQtYSuh3EwnGOJUJ9rmHSietzDyUAFYMcWLau1B05qap58tSDgdYnvVRR2Q5WFMrIWUowf1og2LgDUDhsFi7q4e99M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hgST/QMR; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d715638540so61526131fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1713328099; x=1713932899; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F6Tcs/gsKfX0rDP7padVOSfnNbcx3EzCtWFhBxAybBo=;
        b=hgST/QMRrypDPWL1kJzl5QOpZ37KaI6JM2gV7AQDHvWdSLQwMGG5TmLqWyu8XItI9k
         LFtF+stcD7xlqwnDHoGcJDkRm3yLkcLdPH2nHMhggC2b1fLv0r1cAtu947r/LTzrWTAp
         FF0wF6wI3R/BS9RuCCybRZJWkHGLmU8cGNIbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713328099; x=1713932899;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F6Tcs/gsKfX0rDP7padVOSfnNbcx3EzCtWFhBxAybBo=;
        b=H0lizjS1ugEqhDuB6/An3l0gcIfXsaBIAteZ1j3eFCPbuRCHnIn2MW7BBMMwhpJ1aN
         ZftdlP51I+UhVg3VRPBv4FZDbOWDLwT5NFjJG8BZLOsETeYZcCLuD1c5sCmsKS7+gCR5
         3ejNmN8SB5eKZKHsI95y+L4Y7UKJC29mO2xhhZoRAXYjedQvA/KIN66ZHyaLGRerr9MU
         gZlJDrTQJxxyH6Gg5DT0b/j4N4lpgEj8qmqw1DOMocftLeqyLfTQxd21Z0V/U6nN6K8u
         AZDDDhe4AqNfUFqbnU0irsPwiLOfHTv4m20KcovlpbHOzmRpsWPjv2/GV+lAQnbDkuNT
         YONA==
X-Forwarded-Encrypted: i=1; AJvYcCUw8XycVn3MdxryK6R74+kv2cco8Q30dJ/Pg7gSoK5luBJHLp6PVTTu71XEM567rZ/9hsFfkqEJsFNEgVIMQFGMMrksQ2KsNzR9ehcD
X-Gm-Message-State: AOJu0Yzk+SRY72ppZlsLB/nuVZ27x7eh5x2OtHsgyj1O4FrP5j5QTHkw
	4Ojb/SSlOdXqNsMQYbFawWTfNQzsNvYai8CxZOaXkgtt4tQbEQE+8qrgYy3jZaLzMPG97yZoeYC
	hWfw/7KuK9mRp3gYoKzPOQCj/j9UFSzBBD3Wa
X-Google-Smtp-Source: AGHT+IEHTssG4Qw0IfI3T2INr+lwaqqPSJRZ2lroGwFeVSkrSFtwvoBpDtIZoNLN1jHuIXxHTNE5ZdNNgDgvBxY99Pg=
X-Received: by 2002:a2e:b753:0:b0:2d8:d972:67e0 with SMTP id
 k19-20020a2eb753000000b002d8d97267e0mr8914346ljo.10.1713328099230; Tue, 16
 Apr 2024 21:28:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416050616.6056-1-gakula@marvell.com> <20240416050616.6056-4-gakula@marvell.com>
In-Reply-To: <20240416050616.6056-4-gakula@marvell.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 17 Apr 2024 09:58:07 +0530
Message-ID: <CAH-L+nNp4JxbM+CrQjiaK3FjO7Fx54EGmwcL=1mheRJMnf1URw@mail.gmail.com>
Subject: Re: [net-next PATCH 3/9] octeontx2-pf: Create representor netdev
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c2930506164348fa"

--000000000000c2930506164348fa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 10:37=E2=80=AFAM Geetha sowjanya <gakula@marvell.co=
m> wrote:
>
> Adds initial devlink support to set/get the switchdev mode.
> Representor netdevs are created for each rvu devices when
> the switch mode is set to 'switchdev'. These netdevs are
> be used to control and configure VFs.
>
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---
>  .../marvell/octeontx2/nic/otx2_devlink.c      |  48 ++++++
>  .../net/ethernet/marvell/octeontx2/nic/rep.c  | 159 ++++++++++++++++++
>  .../net/ethernet/marvell/octeontx2/nic/rep.h  |   2 +
>  3 files changed, 209 insertions(+)
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/=
drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
> index 4e1130496573..f4f5f5d93c7e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
> @@ -76,7 +76,53 @@ static const struct devlink_param otx2_dl_params[] =3D=
 {
>                              otx2_dl_mcam_count_validate),
>  };
>
> +#ifdef CONFIG_RVU_ESWITCH
> +static int otx2_devlink_eswitch_mode_get(struct devlink *devlink, u16 *m=
ode)
> +{
> +       struct otx2_devlink *otx2_dl =3D devlink_priv(devlink);
> +       struct otx2_nic *pfvf =3D otx2_dl->pfvf;
> +
> +       if (!is_rep_dev(pfvf->pdev))
> +               return -EOPNOTSUPP;
> +
> +       *mode =3D pfvf->esw_mode;
> +
> +       return 0;
> +}
> +
> +static int otx2_devlink_eswitch_mode_set(struct devlink *devlink, u16 mo=
de,
> +                                        struct netlink_ext_ack *extack)
> +{
> +       struct otx2_devlink *otx2_dl =3D devlink_priv(devlink);
> +       struct otx2_nic *pfvf =3D otx2_dl->pfvf;
> +
> +       if (!is_rep_dev(pfvf->pdev))
> +               return -EOPNOTSUPP;
> +
> +       if (pfvf->esw_mode =3D=3D mode)
> +               return 0;
> +
> +       pfvf->esw_mode =3D mode;
[Kalesh] Move this assignment after the switch block. Else, you will
end up updating pfvf->esw_mode to an unsupported mode even though
drover returns error.
> +       switch (mode) {
> +       case DEVLINK_ESWITCH_MODE_LEGACY:
> +               rvu_rep_destroy(pfvf);
> +               break;
> +       case DEVLINK_ESWITCH_MODE_SWITCHDEV:
> +               rvu_rep_create(pfvf);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +#endif
> +
>  static const struct devlink_ops otx2_devlink_ops =3D {
> +#ifdef CONFIG_RVU_ESWITCH
> +       .eswitch_mode_get =3D otx2_devlink_eswitch_mode_get,
> +       .eswitch_mode_set =3D otx2_devlink_eswitch_mode_set,
> +#endif
>  };
>
>  int otx2_register_dl(struct otx2_nic *pfvf)
> @@ -112,6 +158,7 @@ int otx2_register_dl(struct otx2_nic *pfvf)
>         devlink_free(dl);
>         return err;
>  }
> +EXPORT_SYMBOL(otx2_register_dl);
>
>  void otx2_unregister_dl(struct otx2_nic *pfvf)
>  {
> @@ -123,3 +170,4 @@ void otx2_unregister_dl(struct otx2_nic *pfvf)
>                                   ARRAY_SIZE(otx2_dl_params));
>         devlink_free(dl);
>  }
> +EXPORT_SYMBOL(otx2_unregister_dl);
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/n=
et/ethernet/marvell/octeontx2/nic/rep.c
> index b892a7fe3ddc..fd55ef40c934 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> @@ -28,6 +28,159 @@ MODULE_DESCRIPTION(DRV_STRING);
>  MODULE_LICENSE("GPL");
>  MODULE_DEVICE_TABLE(pci, rvu_rep_id_table);
>
> +static int rvu_rep_napi_init(struct otx2_nic *priv)
> +{
> +       struct otx2_cq_poll *cq_poll =3D NULL;
> +       struct otx2_qset *qset =3D &priv->qset;
> +       struct otx2_hw *hw =3D &priv->hw;
> +       int err =3D 0, qidx, vec;
> +       char *irq_name;
> +
> +       qset->napi =3D kcalloc(hw->cint_cnt, sizeof(*cq_poll), GFP_KERNEL=
);
> +       if (!qset->napi)
> +               return -ENOMEM;
> +
> +       /* Register NAPI handler */
> +       for (qidx =3D 0; qidx < hw->cint_cnt; qidx++) {
> +               cq_poll =3D &qset->napi[qidx];
> +               cq_poll->cint_idx =3D qidx;
> +               cq_poll->cq_ids[CQ_RX] =3D
> +                       (qidx <  hw->rx_queues) ? qidx : CINT_INVALID_CQ;
> +               cq_poll->cq_ids[CQ_TX] =3D (qidx < hw->tx_queues) ?
> +                                         qidx + hw->rx_queues : CINT_INV=
ALID_CQ;
> +               cq_poll->cq_ids[CQ_XDP] =3D CINT_INVALID_CQ;
> +               cq_poll->cq_ids[CQ_QOS] =3D CINT_INVALID_CQ;
> +
> +               cq_poll->dev =3D (void *)priv;
> +               netif_napi_add(priv->reps[qidx]->netdev, &cq_poll->napi,
> +                              otx2_napi_handler);
> +               napi_enable(&cq_poll->napi);
> +       }
> +       /* Register CQ IRQ handlers */
> +       vec =3D hw->nix_msixoff + NIX_LF_CINT_VEC_START;
> +       for (qidx =3D 0; qidx < hw->cint_cnt; qidx++) {
> +               irq_name =3D &hw->irq_name[vec * NAME_SIZE];
> +
> +               snprintf(irq_name, NAME_SIZE, "rep%d-rxtx-%d", qidx, qidx=
);
> +
> +               err =3D request_irq(pci_irq_vector(priv->pdev, vec),
> +                                 otx2_cq_intr_handler, 0, irq_name,
> +                                 &qset->napi[qidx]);
> +               if (err) {
> +                       dev_err(priv->dev,
> +                               "RVU REP IRQ registration failed for CQ%d=
\n", qidx);
> +                       goto err_free_cints;
> +               }
> +               vec++;
> +
> +               /* Enable CQ IRQ */
> +               otx2_write64(priv, NIX_LF_CINTX_INT(qidx), BIT_ULL(0));
> +               otx2_write64(priv, NIX_LF_CINTX_ENA_W1S(qidx), BIT_ULL(0)=
);
> +       }
> +       priv->flags &=3D ~OTX2_FLAG_INTF_DOWN;
> +       return 0;
> +
> +err_free_cints:
> +       otx2_free_cints(priv, qidx);
> +       otx2_disable_napi(priv);
> +       return err;
> +}
> +
> +static void rvu_rep_free_cq_rsrc(struct otx2_nic *priv)
> +{
> +       struct otx2_cq_poll *cq_poll =3D NULL;
> +       struct otx2_qset *qset =3D &priv->qset;
> +       int qidx, vec;
> +
> +       /* Cleanup CQ NAPI and IRQ */
> +       vec =3D priv->hw.nix_msixoff + NIX_LF_CINT_VEC_START;
> +       for (qidx =3D 0; qidx < priv->hw.cint_cnt; qidx++) {
> +               /* Disable interrupt */
> +               otx2_write64(priv, NIX_LF_CINTX_ENA_W1C(qidx), BIT_ULL(0)=
);
> +
> +               synchronize_irq(pci_irq_vector(priv->pdev, vec));
> +
> +               cq_poll =3D &qset->napi[qidx];
> +               napi_synchronize(&cq_poll->napi);
> +               vec++;
> +       }
> +       otx2_free_cints(priv, priv->hw.cint_cnt);
> +       otx2_disable_napi(priv);
> +}
> +
> +static void rvu_rep_free_netdev(struct otx2_nic *priv)
> +{
> +       struct rep_dev *rep;
> +       int rep_id;
> +
> +       for (rep_id =3D 0; rep_id < priv->rep_cnt; rep_id++) {
> +               rep =3D priv->reps[rep_id];
> +               if (rep && rep->netdev->netdev_ops) {
> +                       unregister_netdev(rep->netdev);
> +                       free_netdev(rep->netdev);
> +               }
> +       }
> +       devm_kfree(priv->dev, priv->reps);
> +}
> +
> +void rvu_rep_destroy(struct otx2_nic *priv)
> +{
> +       rvu_rep_free_cq_rsrc(priv);
> +       rvu_rep_free_netdev(priv);
> +}
> +
> +int rvu_rep_create(struct otx2_nic *priv)
> +{
> +       int rep_cnt =3D priv->rep_cnt;
> +       struct net_device *ndev;
> +       struct rep_dev *rep;
> +       int rep_id, err;
> +       u16 pcifunc;
> +
> +       priv->reps =3D devm_kcalloc(priv->dev, rep_cnt, sizeof(struct rep=
_dev), GFP_KERNEL);
> +       if (!priv->reps)
> +               return -ENOMEM;
> +
> +       for (rep_id =3D 0; rep_id < rep_cnt; rep_id++) {
> +               ndev =3D alloc_etherdev(sizeof(*rep));
> +               if (!ndev) {
> +                       dev_err(priv->dev, "PFVF representor:%d creation =
failed\n", rep_id);
> +                       err =3D -ENOMEM;
> +                       goto exit;
> +               }
> +
> +               rep =3D netdev_priv(ndev);
> +               priv->reps[rep_id] =3D rep;
> +               rep->mdev =3D priv;
> +               rep->netdev =3D ndev;
> +               rep->rep_id =3D rep_id;
> +
> +               ndev->min_mtu =3D OTX2_MIN_MTU;
> +               ndev->max_mtu =3D priv->hw.max_mtu;
> +               pcifunc =3D priv->rep_pf_map[rep_id];
> +               rep->pcifunc =3D pcifunc;
> +
> +               snprintf(ndev->name, sizeof(ndev->name), "r%dp%dv%d", rep=
_id,
> +                        rvu_get_pf(pcifunc), (pcifunc & RVU_PFVF_FUNC_MA=
SK));
> +
> +               eth_hw_addr_random(ndev);
> +               if (register_netdev(ndev)) {
> +                       dev_err(priv->dev, "PFVF reprentator registration=
 failed\n");
> +                       free_netdev(ndev);
> +                       ndev->netdev_ops =3D NULL;
[Kalesh] update "rc" with the return status of register_netdev()
> +                       goto exit;
> +               }
> +       }
> +       err =3D rvu_rep_napi_init(priv);
> +       if (err)
> +               goto exit;
> +
> +       return 0;
> +exit:
> +       rvu_rep_free_netdev(priv);
> +       return err;
> +}
> +
>  static int rvu_rep_rsrc_free(struct otx2_nic *priv)
>  {
>         struct otx2_qset *qset =3D &priv->qset;
> @@ -162,6 +315,10 @@ static int rvu_rep_probe(struct pci_dev *pdev, const=
 struct pci_device_id *id)
>         if (err)
>                 goto err_detach_rsrc;
>
> +       err =3D otx2_register_dl(priv);
> +       if (err)
> +               goto err_detach_rsrc;
> +
>         return 0;
>
>  err_detach_rsrc:
> @@ -183,6 +340,8 @@ static void rvu_rep_remove(struct pci_dev *pdev)
>  {
>         struct otx2_nic *priv =3D pci_get_drvdata(pdev);
>
> +       otx2_unregister_dl(priv);
> +       rvu_rep_destroy(priv);
>         rvu_rep_rsrc_free(priv);
>         otx2_detach_resources(&priv->mbox);
>         if (priv->hw.lmt_info)
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h b/drivers/n=
et/ethernet/marvell/octeontx2/nic/rep.h
> index 30cce17eb48b..be6c939e5cba 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
> @@ -29,4 +29,6 @@ static inline bool is_rep_dev(struct pci_dev *pdev)
>         return pdev->device =3D=3D PCI_DEVID_RVU_REP;
>  }
>
> +int rvu_rep_create(struct otx2_nic *priv);
> +void rvu_rep_destroy(struct otx2_nic *priv);
>  #endif /* REP_H */
> --
> 2.25.1
>
>


--=20
Regards,
Kalesh A P

--000000000000c2930506164348fa
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
AQkEMSIEIMhfOnfVK0uqgyuiszHuPVRLmjDxlRmKGNbE2MKV5xGvMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQxNzA0MjgxOVowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAB/F1M4OVF
2YfgZwFtMyirMiOz7Aa9x25m/y+BTAXiqF+/596Jdf4YY7BHGUKezDs0cYKmBFggkhcIuI5Q72pz
A6wVt7LYICnZxwgNSRM3pDsuqnp6caRq3tYsDRnu1sJrV4SPbqnro7dYFibI33hm+w6Cqeqgp+mH
xzonOa5Krwax7KaxX3c1IuRb2Pnt4xjbfBh7YvwQHhhmD9H9oPQRbY63weKx3dynXt2F8vfvhVDs
B/op9qKER9XozXQQ1W3Iii7r+iaxxAwB/ThDGxaqMcJeDRb66+3Ubu3a4wHrjarCgeLCK/tYBc6h
mnuLwtglsjVBKfnhmrxjJMT6T+DF
--000000000000c2930506164348fa--

