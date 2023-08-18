Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC46D781080
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378611AbjHRQjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378594AbjHRQi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:38:56 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DB42D64
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 09:38:54 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe8242fc4dso11000285e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 09:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1692376733; x=1692981533;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iy5teLYRzh5Chc7V5tHgLwkLCINrHVYtJKERQQGcS0o=;
        b=L2o0cdTmZjvBJu9j4+nGgNgyhEy7XzeeX/txNSkd9y//vtf4BgKoVj4oQ/iRwmYWaZ
         J7eSHfL/zKp0iSx2D8/QSxjKdnlZhz2mm5uyjH9TzBaDQV5EGbkTim45fbQ0cVIHlhYp
         4AFEuIhKDFLy9FAv//HLt3/945mEESpx/r1ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692376733; x=1692981533;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iy5teLYRzh5Chc7V5tHgLwkLCINrHVYtJKERQQGcS0o=;
        b=aWnisf86kLazL3WBXKEZk1CixTd23vDNIIJCqlzss3wz80WSBPzWdAMkU78TYdwdUc
         GJ4JZJmzQ7gnNUrVHA0whlWZ1ryFLyYSL+Y4LmtAJguNa2SpadW9pkn+5seyV+Bt693U
         pMSSeX69QdSOwDtY2w5sssUqLYb57ySKp3n0PTAwlpwvB7b/VIchJRE4IPeN4TkiDwa9
         qVZtTnZ5c4bWQeVMa4+GKoKTgcF9p/IyYcFRAbU6UaYtt+/mXuhwtKW1gSIKYZG7qY9v
         sxBstktA7orjj2vu5DUUCzYR3Q6KC2eS/dd6x6Zt7ficN0Ng4i6UUMeWUq+5vG8Hr2eO
         JRhQ==
X-Gm-Message-State: AOJu0YxvnVSyz545PUSZfse+tm8qKwFzknA3Bv6OHdZOFyYQKBXQScgQ
        M6sPo8D27w1H/4OUpeWbBq25CZwcKb/4W6iTEEbtZfQBTXhHgfi1CrNM0J6fle6Llp12AAz+e4n
        EzlGiLQxU8ZSW/KsQwwCfEU64bSjfUAM=
X-Google-Smtp-Source: AGHT+IGYJTvPQvDOknuNCul1TomOrAN+2k4GmXj6zZuHXE6aPNwSXH76hTgL4953dyFM9H1FDSGuyomTq1irShzfntI=
X-Received: by 2002:a5d:428d:0:b0:31a:d9bc:47aa with SMTP id
 k13-20020a5d428d000000b0031ad9bc47aamr2334683wrq.67.1692376732916; Fri, 18
 Aug 2023 09:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230818155452.875781-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230818155452.875781-1-andriy.shevchenko@linux.intel.com>
From:   Justin Tee <justin.tee@broadcom.com>
Date:   Fri, 18 Aug 2023 09:38:41 -0700
Message-ID: <CAAmqgVMFQKg4cKbT4_pdh3TTT0_ft8adQuWMwaKA2U8GdRS2Ag@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] scsi: lpfc: Do not abuse UUID APIs and LPFC_COMPRESS_VMID_SIZE
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000049b870603352a53"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000049b870603352a53
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

Thanks!

Reviewed-by: Justin Tee <justin.tee@broadcom.com>

Regards,
Justin


On Fri, Aug 18, 2023 at 8:55=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The lpfc_vmid_host_uuid is not defined as uuid_t and its usage is not
> the same as for uuid_t operations (like exporting or importing).
> Hence replace call to uuid_is_null() by respective memchr_inv() without
> abusing casting.
>
> With that, replace LPFC_COMPRESS_VMID_SIZE with plain number and
> respective sizeof() to make code robust to changes in the future,
> if any.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v3: dropped LPFC_COMPRESS_VMID_SIZE completely at the same time
>  drivers/scsi/lpfc/lpfc.h     |  3 +--
>  drivers/scsi/lpfc/lpfc_els.c | 12 +++++++-----
>  2 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
> index bc1c5f6df090..af15f7a22d25 100644
> --- a/drivers/scsi/lpfc/lpfc.h
> +++ b/drivers/scsi/lpfc/lpfc.h
> @@ -309,7 +309,6 @@ struct lpfc_hba;
>  #define LPFC_VMID_TIMER   300  /* timer interval in seconds */
>
>  #define LPFC_MAX_VMID_SIZE      256
> -#define LPFC_COMPRESS_VMID_SIZE 16
>
>  union lpfc_vmid_io_tag {
>         u32 app_id;     /* App Id vmid */
> @@ -667,7 +666,7 @@ struct lpfc_vport {
>         uint32_t cfg_first_burst_size;
>         uint32_t dev_loss_tmo_changed;
>         /* VMID parameters */
> -       u8 lpfc_vmid_host_uuid[LPFC_COMPRESS_VMID_SIZE];
> +       u8 lpfc_vmid_host_uuid[16];
>         u32 max_vmid;   /* maximum VMIDs allowed per port */
>         u32 cur_vmid_cnt;       /* Current VMID count */
>  #define LPFC_MIN_VMID  4
> diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
> index b5cd6d1c0a5a..54e47f268235 100644
> --- a/drivers/scsi/lpfc/lpfc_els.c
> +++ b/drivers/scsi/lpfc/lpfc_els.c
> @@ -1331,7 +1331,8 @@ lpfc_issue_els_flogi(struct lpfc_vport *vport, stru=
ct lpfc_nodelist *ndlp,
>         if (phba->cfg_vmid_priority_tagging) {
>                 sp->cmn.priority_tagging =3D 1;
>                 /* lpfc_vmid_host_uuid is combination of wwpn and wwnn */
> -               if (uuid_is_null((uuid_t *)vport->lpfc_vmid_host_uuid)) {
> +               if (!memchr_inv(vport->lpfc_vmid_host_uuid, 0,
> +                               sizeof(vport->lpfc_vmid_host_uuid))) {
>                         memcpy(vport->lpfc_vmid_host_uuid, phba->wwpn,
>                                sizeof(phba->wwpn));
>                         memcpy(&vport->lpfc_vmid_host_uuid[8], phba->wwnn=
,
> @@ -12357,9 +12358,10 @@ lpfc_vmid_uvem(struct lpfc_vport *vport,
>         elsiocb->vmid_tag.vmid_context =3D vmid_context;
>         pcmd =3D (u8 *)elsiocb->cmd_dmabuf->virt;
>
> -       if (uuid_is_null((uuid_t *)vport->lpfc_vmid_host_uuid))
> +       if (!memchr_inv(vport->lpfc_vmid_host_uuid, 0,
> +                       sizeof(vport->lpfc_vmid_host_uuid)))
>                 memcpy(vport->lpfc_vmid_host_uuid, vmid->host_vmid,
> -                      LPFC_COMPRESS_VMID_SIZE);
> +                      sizeof(vport->lpfc_vmid_host_uuid));
>
>         *((u32 *)(pcmd)) =3D ELS_CMD_UVEM;
>         len =3D (u32 *)(pcmd + 4);
> @@ -12369,13 +12371,13 @@ lpfc_vmid_uvem(struct lpfc_vport *vport,
>         vem_id_desc->tag =3D be32_to_cpu(VEM_ID_DESC_TAG);
>         vem_id_desc->length =3D be32_to_cpu(LPFC_UVEM_VEM_ID_DESC_SIZE);
>         memcpy(vem_id_desc->vem_id, vport->lpfc_vmid_host_uuid,
> -              LPFC_COMPRESS_VMID_SIZE);
> +              sizeof(vem_id_desc->vem_id));
>
>         inst_desc =3D (struct instantiated_ve_desc *)(pcmd + 32);
>         inst_desc->tag =3D be32_to_cpu(INSTANTIATED_VE_DESC_TAG);
>         inst_desc->length =3D be32_to_cpu(LPFC_UVEM_VE_MAP_DESC_SIZE);
>         memcpy(inst_desc->global_vem_id, vmid->host_vmid,
> -              LPFC_COMPRESS_VMID_SIZE);
> +              sizeof(inst_desc->global_vem_id));
>
>         bf_set(lpfc_instantiated_nport_id, inst_desc, vport->fc_myDID);
>         bf_set(lpfc_instantiated_local_id, inst_desc,
> --
> 2.40.0.1.gaa8946217a0b
>

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

--000000000000049b870603352a53
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
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEQ7PuPr+NXOE++RWjUm+xOk9FxW8pI1mXzso8fm
F5xLMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDgxODE2Mzg1
M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQCRhOWetwwHWNjecinj7SoNJtiVbS3RMnEylKUVPohjk+bHCo2Y6dUM+jQH
egNIPLwnUNLPrp0DK/a7OvkRv3tb/NwJMpPN4GWpMoPaC/iie3ndbf3BzyY4vlg4uf7j47b1wYK5
vNmOk7WhTqhXm3PuUWmtciotfQMZsPmbyn7IpPfdGxt5KGuEQOuJqmVTNhh7M4jaNZvmePpi5apt
s3j+sl8a2bzIQ4LkhLN+kuW9xbtSYPYX8TiTm384/nTtdhYe20Iby1gdVFsX9vUFLOOkQKTOg4mq
t8QYqIHqpci+2tMjhycc5BgQAqYaGmSa35y8HLtfju1ypNMCpA2R7e9X
--000000000000049b870603352a53--
