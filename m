Return-Path: <linux-kernel+bounces-147219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 559388A711C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78ACA1C21BCB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617F212EBCB;
	Tue, 16 Apr 2024 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LvwEmY5K"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B822113119E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284287; cv=none; b=XCpWTEB8KLWKpin9dsD0me61NU7XkbarkpuHUl4nD0qCkgo7DiQFSO+72FoT7Y6Z2qwgIBLd2sriZKDSjHVKl6FbPu+h1N91UhBrdHzPxqIcwpMLMl9mf+fX2ObUWdrgvEETj8paXkYvCW8wVVzeRMV3mWufY6BuNgunG316vMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284287; c=relaxed/simple;
	bh=yP/aIZf8Rkv4ERAupvBcxcOehWNu5MWFY23+tXTmJGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SypGZf1GAaFN6uR85G4BnCFOLQLDmcODOQbYbvEHAdREwz681Wb/kXkzAC3xg/G4b3+pyXCFn7pNeaYk0/crTkhY6S8XSQQP77R1MMMJ7EIQRrvwB075GXAfO/sn0rtOXux2JWyJLg6aLwSFXecUuj2Zy0rrLvaSZSWQZ7cNQek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LvwEmY5K; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516d0162fa1so5878409e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 09:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1713284283; x=1713889083; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TIVAWcgidJ0OA7neZ5s/LX9vP8exwr/rYdbbyB5oLnY=;
        b=LvwEmY5KdMktwzc2mbUkwj0EfOgEEreBRFdjXvOyFDfhQvaC8A0HIz3qCdzr/3Da8/
         s8Az/8WG0VAqnaN2aiewbwUYLaWS43EXgGirJBZjC/1JGdeATGRhiTSk8cSVw1nlJTrP
         yc8UaUAeL/YSb3kDOIR8GTnAmI6YURGY/y/Jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713284283; x=1713889083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TIVAWcgidJ0OA7neZ5s/LX9vP8exwr/rYdbbyB5oLnY=;
        b=XDZXIqOzWbtnXojwVS3G3NrEB41uKKyLoR996MI+lkRTDQy5LHohb857jkMlQi4uml
         vRxzLS8hir8VDWX15wnd06vOkLEKm9/vu6mIZ3dfzcbWklYVBpYcVerags+NiSpew5cn
         3NazIL2S/hA1S5zSm8KcYHyFBliTi4hwokuRSdfCg+2IhqPJFJZMuNizr20cP3m5ktB3
         BymKkWYY/W/1ChQcHMTi9BHMz+VjLlVLbDsPNuJyXwQLFsl+aJ6njUZyJovNOgiWygvd
         BpSz8w0+o/DKy+j/S5DQ9MWEfGkkaCHN9b1JpQQGyzSVJodWSlGsaaNazDzA+W6AoYuW
         WS0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdwZh0jtC63qoNFUjjtQRtgdqpK7iYYPbPbMy4EQM0G4pFm5gBvkFK4fV6R+3RXMPHXMuAKYp9WpLqnNe2tsEk4mgVEOigCh45ePsV
X-Gm-Message-State: AOJu0Ywt4OQDRdRnBb/3JSr/hC1lwkN8PHXL7a9Gb5tVp3L2b7wb84Na
	M4it7gWb1/AOrjDdA1f7VvV6NCAFlqiA6A7lTEodfL1n6jKjfHDtR0BTHHciibxA7UJ9ZnOo6ea
	z4n2LrUpKYzSZ+kZ+AtLbhs4DKdQvHy9MQ9cM
X-Google-Smtp-Source: AGHT+IHd3FuMdkRH2B+m1t22F5J0b9lB9i76uqs/HVE2M1qIhyR/juqTrWYrvg9PEcbvZCvdu2fwNVBha52/X8Mf9Do=
X-Received: by 2002:ac2:5b08:0:b0:518:a17a:2331 with SMTP id
 v8-20020ac25b08000000b00518a17a2331mr7207744lfn.65.1713284282651; Tue, 16 Apr
 2024 09:18:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416050616.6056-1-gakula@marvell.com> <20240416050616.6056-3-gakula@marvell.com>
In-Reply-To: <20240416050616.6056-3-gakula@marvell.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 16 Apr 2024 21:47:50 +0530
Message-ID: <CAH-L+nNJ2QB5jVudi1D9vYk_0W_8z22Fh8gLZuJKwLtapMr-hw@mail.gmail.com>
Subject: Re: [net-next PATCH 2/9] octeontx2-pf: RVU representor driver
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001a9d190616391558"

--0000000000001a9d190616391558
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 10:37=E2=80=AFAM Geetha sowjanya <gakula@marvell.co=
m> wrote:
>
> This patch adds basic driver for the RVU representor.
> Driver on probe does pci specific initialization and does hw
> resources configuration.
> Introduces RVU_ESWITCH kernel config to enable/disable
> this driver. Representor and NIC shares the code but represenotrs
> netdev support subset of NIC functionality. Hence "is_rep_dev"
> api helps to skip the features initialization that are not supported
> by the representors.
>
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---
>  .../net/ethernet/marvell/octeontx2/Kconfig    |   8 +
>  .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
>  .../net/ethernet/marvell/octeontx2/af/mbox.h  |   8 +
>  .../net/ethernet/marvell/octeontx2/af/rvu.h   |  11 +
>  .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  19 +-
>  .../ethernet/marvell/octeontx2/af/rvu_rep.c   |  48 ++++
>  .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +
>  .../marvell/octeontx2/nic/otx2_common.h       |  12 +-
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  17 +-
>  .../marvell/octeontx2/nic/otx2_txrx.c         |  19 +-
>  .../net/ethernet/marvell/octeontx2/nic/rep.c  | 221 ++++++++++++++++++
>  .../net/ethernet/marvell/octeontx2/nic/rep.h  |  32 +++
>  12 files changed, 383 insertions(+), 17 deletions(-)
>  create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
>  create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>  create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.h
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/Kconfig b/drivers/net=
/ethernet/marvell/octeontx2/Kconfig
> index a32d85d6f599..72f57d6f8a87 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/Kconfig
> +++ b/drivers/net/ethernet/marvell/octeontx2/Kconfig
> @@ -46,3 +46,11 @@ config OCTEONTX2_VF
>         depends on OCTEONTX2_PF
>         help
>           This driver supports Marvell's OcteonTX2 NIC virtual function.
> +
> +config RVU_ESWITCH
> +       tristate "Marvell RVU E-Switch support"
> +       depends on OCTEONTX2_PF && NET_SWITCHDEV
> +       default m
> +       help
> +         This driver supports Marvell's RVU E-Switch that
> +         provides internal SRIOV packet steering and switching for the
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/Makefile b/drivers=
/net/ethernet/marvell/octeontx2/af/Makefile
> index 3cf4c8285c90..ccea37847df8 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/Makefile
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
> @@ -11,4 +11,5 @@ rvu_mbox-y :=3D mbox.o rvu_trace.o
>  rvu_af-y :=3D cgx.o rvu.o rvu_cgx.o rvu_npa.o rvu_nix.o \
>                   rvu_reg.o rvu_npc.o rvu_debugfs.o ptp.o rvu_npc_fs.o \
>                   rvu_cpt.o rvu_devlink.o rpm.o rvu_cn10k.o rvu_switch.o =
\
> -                 rvu_sdp.o rvu_npc_hash.o mcs.o mcs_rvu_if.o mcs_cnf10kb=
o
> +                 rvu_sdp.o rvu_npc_hash.o mcs.o mcs_rvu_if.o mcs_cnf10kb=
o \
> +                 rvu_rep.o
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/n=
et/ethernet/marvell/octeontx2/af/mbox.h
> index 10efbd56abd1..c77c02730cf9 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -143,6 +143,7 @@ M(LMTST_TBL_SETUP,  0x00a, lmtst_tbl_setup, lmtst_tbl=
_setup_req,    \
>                                 msg_rsp)                                \
>  M(SET_VF_PERM,         0x00b, set_vf_perm, set_vf_perm, msg_rsp)       \
>  M(PTP_GET_CAP,         0x00c, ptp_get_cap, msg_req, ptp_get_cap_rsp)   \
> +M(GET_REP_CNT,         0x00d, get_rep_cnt, msg_req, get_rep_cnt_rsp)   \
>  /* CGX mbox IDs (range 0x200 - 0x3FF) */                               \
>  M(CGX_START_RXTX,      0x200, cgx_start_rxtx, msg_req, msg_rsp)        \
>  M(CGX_STOP_RXTX,       0x201, cgx_stop_rxtx, msg_req, msg_rsp)         \
> @@ -1524,6 +1525,13 @@ struct ptp_get_cap_rsp {
>         u64 cap;
>  };
>
> +struct get_rep_cnt_rsp {
> +       struct mbox_msghdr hdr;
> +       u16 rep_cnt;
> +       u16 rep_pf_map[64];
> +       u64 rsvd;
> +};
> +
>  struct flow_msg {
>         unsigned char dmac[6];
>         unsigned char smac[6];
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/ne=
t/ethernet/marvell/octeontx2/af/rvu.h
> index e7ff2f1b021f..1d76d52d7a5d 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> @@ -593,6 +593,9 @@ struct rvu {
>         spinlock_t              cpt_intr_lock;
>
>         struct mutex            mbox_lock; /* Serialize mbox up and down =
msgs */
> +       u16                     rep_pcifunc;
> +       int                     rep_cnt;
> +       u16                     *rep2pfvf_map;
>  };
>
>  static inline void rvu_write64(struct rvu *rvu, u64 block, u64 offset, u=
64 val)
> @@ -821,6 +824,14 @@ bool is_sdp_pfvf(u16 pcifunc);
>  bool is_sdp_pf(u16 pcifunc);
>  bool is_sdp_vf(struct rvu *rvu, u16 pcifunc);
>
> +static inline bool is_rep_dev(struct rvu *rvu, u16 pcifunc)
> +{
> +       if (rvu->rep_pcifunc && rvu->rep_pcifunc =3D=3D pcifunc)
> +               return true;
> +
> +       return false;
> +}
> +
>  /* CGX APIs */
>  static inline bool is_pf_cgxmapped(struct rvu *rvu, u8 pf)
>  {
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/driver=
s/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index cb795d09971e..4ef5bb7b337f 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -329,7 +329,8 @@ static bool is_valid_txschq(struct rvu *rvu, int blka=
ddr,
>
>         /* TLs aggegating traffic are shared across PF and VFs */
>         if (lvl >=3D hw->cap.nix_tx_aggr_lvl) {
> -               if (rvu_get_pf(map_func) !=3D rvu_get_pf(pcifunc))
> +               if ((nix_get_tx_link(rvu, map_func) !=3D nix_get_tx_link(=
rvu, pcifunc)) &&
> +                   (rvu_get_pf(map_func) !=3D rvu_get_pf(pcifunc)))
>                         return false;
>                 else
>                         return true;
> @@ -1631,6 +1632,12 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>         cfg =3D NPC_TX_DEF_PKIND;
>         rvu_write64(rvu, blkaddr, NIX_AF_LFX_TX_PARSE_CFG(nixlf), cfg);
>
> +       if (is_rep_dev(rvu, pcifunc)) {
> +               pfvf->tx_chan_base =3D RVU_SWITCH_LBK_CHAN;
> +               pfvf->tx_chan_cnt =3D 1;
> +               goto exit;
> +       }
> +
>         intf =3D is_lbk_vf(rvu, pcifunc) ? NIX_INTF_TYPE_LBK : NIX_INTF_T=
YPE_CGX;
>         if (is_sdp_pfvf(pcifunc))
>                 intf =3D NIX_INTF_TYPE_SDP;
> @@ -1701,6 +1708,9 @@ int rvu_mbox_handler_nix_lf_free(struct rvu *rvu, s=
truct nix_lf_free_req *req,
>         if (nixlf < 0)
>                 return NIX_AF_ERR_AF_LF_INVALID;
>
> +       if (is_rep_dev(rvu, pcifunc))
> +               goto free_lf;
> +
>         if (req->flags & NIX_LF_DISABLE_FLOWS)
>                 rvu_npc_disable_mcam_entries(rvu, pcifunc, nixlf);
>         else
> @@ -1712,6 +1722,7 @@ int rvu_mbox_handler_nix_lf_free(struct rvu *rvu, s=
truct nix_lf_free_req *req,
>
>         nix_interface_deinit(rvu, pcifunc, nixlf);
>
> +free_lf:
>         /* Reset this NIX LF */
>         err =3D rvu_lf_reset(rvu, block, nixlf);
>         if (err) {
> @@ -2007,7 +2018,7 @@ static void nix_get_txschq_range(struct rvu *rvu, u=
16 pcifunc,
>         struct rvu_hwinfo *hw =3D rvu->hw;
>         int pf =3D rvu_get_pf(pcifunc);
>
> -       if (is_lbk_vf(rvu, pcifunc)) { /* LBK links */
> +       if (is_lbk_vf(rvu, pcifunc) || is_rep_dev(rvu, pcifunc)) { /* LBK=
 links */
>                 *start =3D hw->cap.nix_txsch_per_cgx_lmac * link;
>                 *end =3D *start + hw->cap.nix_txsch_per_lbk_lmac;
>         } else if (is_pf_cgxmapped(rvu, pf)) { /* CGX links */
> @@ -4519,7 +4530,7 @@ int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu=
, struct nix_frs_cfg *req,
>         if (!nix_hw)
>                 return NIX_AF_ERR_INVALID_NIXBLK;
>
> -       if (is_lbk_vf(rvu, pcifunc))
> +       if (is_lbk_vf(rvu, pcifunc) || is_rep_dev(rvu, pcifunc))
>                 rvu_get_lbk_link_max_frs(rvu, &max_mtu);
>         else
>                 rvu_get_lmac_link_max_frs(rvu, &max_mtu);
> @@ -4547,6 +4558,8 @@ int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu=
, struct nix_frs_cfg *req,
>                 /* For VFs of PF0 ingress is LBK port, so config LBK link=
 */
>                 pfvf =3D rvu_get_pfvf(rvu, pcifunc);
>                 link =3D hw->cgx_links + pfvf->lbkid;
> +       } else if (is_rep_dev(rvu, pcifunc)) {
> +               link =3D hw->cgx_links + 0;
>         }
>
>         if (link < 0)
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/driver=
s/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> new file mode 100644
> index 000000000000..d07cb356d3d6
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell RVU Admin Function driver
> + *
> + * Copyright (C) 2024 Marvell.
> + *
> + */
> +
> +#include <linux/types.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +
> +#include "rvu.h"
> +#include "rvu_reg.h"
> +
> +int rvu_mbox_handler_get_rep_cnt(struct rvu *rvu, struct msg_req *req,
> +                                struct get_rep_cnt_rsp *rsp)
> +{
> +       int pf, vf, numvfs, hwvf, rep =3D 0;
> +       u16 pcifunc;
> +
> +       rvu->rep_pcifunc =3D req->hdr.pcifunc;
> +       rsp->rep_cnt =3D rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs;
> +       rvu->rep_cnt =3D rsp->rep_cnt;
> +
> +       rvu->rep2pfvf_map =3D devm_kzalloc(rvu->dev, rvu->rep_cnt *
> +                                        sizeof(u16), GFP_KERNEL);
[Kalesh] Any reason to use "devm_kzalloc" here? Why not kzalloc()
> +       if (!rvu->rep2pfvf_map)
> +               return -ENOMEM;
> +
> +       for (pf =3D 0; pf < rvu->hw->total_pfs; pf++) {
> +               if (!is_pf_cgxmapped(rvu, pf))
> +                       continue;
> +               pcifunc =3D pf << RVU_PFVF_PF_SHIFT;
> +               rvu->rep2pfvf_map[rep] =3D pcifunc;
> +               rsp->rep_pf_map[rep] =3D pcifunc;
> +               rep++;
> +               rvu_get_pf_numvfs(rvu, pf, &numvfs, &hwvf);
> +               for (vf =3D 0; vf < numvfs; vf++) {
> +                       rvu->rep2pfvf_map[rep] =3D pcifunc |
> +                               ((vf + 1) & RVU_PFVF_FUNC_MASK);
> +                       rsp->rep_pf_map[rep] =3D rvu->rep2pfvf_map[rep];
> +                       rep++;
> +               }
> +       }
> +       return 0;
> +}
> +
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile b/driver=
s/net/ethernet/marvell/octeontx2/nic/Makefile
> index 5664f768cb0c..69ee78dc8aad 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
> @@ -5,11 +5,13 @@
>
>  obj-$(CONFIG_OCTEONTX2_PF) +=3D rvu_nicpf.o otx2_ptp.o
>  obj-$(CONFIG_OCTEONTX2_VF) +=3D rvu_nicvf.o otx2_ptp.o
> +obj-$(CONFIG_RVU_ESWITCH) +=3D rvu_rep.o
>
>  rvu_nicpf-y :=3D otx2_pf.o otx2_common.o otx2_txrx.o otx2_ethtool.o \
>                 otx2_flows.o otx2_tc.o cn10k.o otx2_dmac_flt.o \
>                 otx2_devlink.o qos_sq.o qos.o
>  rvu_nicvf-y :=3D otx2_vf.o otx2_devlink.o
> +rvu_rep-y :=3D rep.o
>
>  rvu_nicpf-$(CONFIG_DCB) +=3D otx2_dcbnl.o
>  rvu_nicvf-$(CONFIG_DCB) +=3D otx2_dcbnl.o
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/d=
rivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index e6d7b2487ed1..79ec86035c16 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> @@ -29,6 +29,7 @@
>  #include "otx2_devlink.h"
>  #include <rvu_trace.h>
>  #include "qos.h"
> +#include "rep.h"
>
>  /* IPv4 flag more fragment bit */
>  #define IPV4_FLAG_MORE                         0x20
> @@ -439,6 +440,7 @@ struct otx2_nic {
>  #define OTX2_FLAG_DMACFLTR_SUPPORT             BIT_ULL(14)
>  #define OTX2_FLAG_PTP_ONESTEP_SYNC             BIT_ULL(15)
>  #define OTX2_FLAG_ADPTV_INT_COAL_ENABLED BIT_ULL(16)
> +#define OTX2_FLAG_REP_MODE_ENABLED              BIT_ULL(17)
>         u64                     flags;
>         u64                     *cq_op_addr;
>
> @@ -506,11 +508,19 @@ struct otx2_nic {
>  #if IS_ENABLED(CONFIG_MACSEC)
>         struct cn10k_mcs_cfg    *macsec_cfg;
>  #endif
> +
> +#if IS_ENABLED(CONFIG_RVU_ESWITCH)
> +       struct rep_dev          **reps;
> +       int                     rep_cnt;
> +       u16                     rep_pf_map[RVU_MAX_REP];
> +       u16                     esw_mode;
> +#endif
>  };
>
>  static inline bool is_otx2_lbkvf(struct pci_dev *pdev)
>  {
> -       return pdev->device =3D=3D PCI_DEVID_OCTEONTX2_RVU_AFVF;
> +       return (pdev->device =3D=3D PCI_DEVID_OCTEONTX2_RVU_AFVF) ||
> +               (pdev->device =3D=3D PCI_DEVID_RVU_REP);
>  }
>
>  static inline bool is_96xx_A0(struct pci_dev *pdev)
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index 88886ea864cc..119c99768a85 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -1502,10 +1502,11 @@ int otx2_init_hw_resources(struct otx2_nic *pf)
>         hw->sqpool_cnt =3D otx2_get_total_tx_queues(pf);
>         hw->pool_cnt =3D hw->rqpool_cnt + hw->sqpool_cnt;
>
> -       /* Maximum hardware supported transmit length */
> -       pf->tx_max_pktlen =3D pf->netdev->max_mtu + OTX2_ETH_HLEN;
> -
> -       pf->rbsize =3D otx2_get_rbuf_size(pf, pf->netdev->mtu);
> +       if (!is_rep_dev(pf->pdev)) {
> +               /* Maximum hardware supported transmit length */
> +               pf->tx_max_pktlen =3D pf->netdev->max_mtu + OTX2_ETH_HLEN=
;
> +               pf->rbsize =3D otx2_get_rbuf_size(pf, pf->netdev->mtu);
> +       }
>
>         mutex_lock(&mbox->lock);
>         /* NPA init */
> @@ -1634,11 +1635,12 @@ void otx2_free_hw_resources(struct otx2_nic *pf)
>                 otx2_pfc_txschq_stop(pf);
>  #endif
>
> -       otx2_clean_qos_queues(pf);
> +       if (!is_rep_dev(pf->pdev))
> +               otx2_clean_qos_queues(pf);
>
>         mutex_lock(&mbox->lock);
>         /* Disable backpressure */
> -       if (!(pf->pcifunc & RVU_PFVF_FUNC_MASK))
> +       if (!is_otx2_lbkvf(pf->pdev))
>                 otx2_nix_config_bp(pf, false);
>         mutex_unlock(&mbox->lock);
>
> @@ -1670,7 +1672,8 @@ void otx2_free_hw_resources(struct otx2_nic *pf)
>         otx2_free_cq_res(pf);
>
>         /* Free all ingress bandwidth profiles allocated */
> -       cn10k_free_all_ipolicers(pf);
> +       if (!is_rep_dev(pf->pdev))
> +               cn10k_free_all_ipolicers(pf);
>
>         mutex_lock(&mbox->lock);
>         /* Reset NIX LF */
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/dri=
vers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index 8223780fc269..2a2cfa77bd4d 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -375,11 +375,13 @@ static void otx2_rcv_pkt_handler(struct otx2_nic *p=
fvf,
>                 }
>                 start +=3D sizeof(*sg);
>         }
> -       otx2_set_rxhash(pfvf, cqe, skb);
>
> -       skb_record_rx_queue(skb, cq->cq_idx);
> -       if (pfvf->netdev->features & NETIF_F_RXCSUM)
> -               skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> +       if (!(pfvf->flags & OTX2_FLAG_REP_MODE_ENABLED)) {
> +               otx2_set_rxhash(pfvf, cqe, skb);
> +               skb_record_rx_queue(skb, cq->cq_idx);
> +               if (pfvf->netdev->features & NETIF_F_RXCSUM)
> +                       skb->ip_summed =3D CHECKSUM_UNNECESSARY;
> +       }
>
>         skb_mark_for_recycle(skb);
>
> @@ -463,7 +465,11 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfv=
f,
>  process_cqe:
>         qidx =3D cq->cq_idx - pfvf->hw.rx_queues;
>         sq =3D &pfvf->qset.sq[qidx];
> -       ndev =3D pfvf->netdev;
> +
> +       if (pfvf->flags & OTX2_FLAG_REP_MODE_ENABLED)
> +               ndev =3D pfvf->reps[qidx]->netdev;
> +       else
> +               ndev =3D pfvf->netdev;
>
>         while (likely(processed_cqe < budget) && cq->pend_cqe) {
>                 cqe =3D (struct nix_cqe_tx_s *)otx2_get_next_cqe(cq);
> @@ -500,6 +506,9 @@ static int otx2_tx_napi_handler(struct otx2_nic *pfvf=
,
>
>                 if (qidx >=3D pfvf->hw.tx_queues)
>                         qidx -=3D pfvf->hw.xdp_queues;
> +
> +               if (pfvf->flags & OTX2_FLAG_REP_MODE_ENABLED)
> +                       qidx =3D 0;
>                 txq =3D netdev_get_tx_queue(pfvf->netdev, qidx);
>                 netdev_tx_completed_queue(txq, tx_pkts, tx_bytes);
>                 /* Check if queue was stopped earlier due to ring full */
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/n=
et/ethernet/marvell/octeontx2/nic/rep.c
> new file mode 100644
> index 000000000000..b892a7fe3ddc
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> @@ -0,0 +1,221 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell RVU representor driver
> + *
> + * Copyright (C) 2024 Marvell.
> + *
> + */
> +
> +#include <linux/etherdevice.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/net_tstamp.h>
> +
> +#include "otx2_common.h"
> +#include "cn10k.h"
> +#include "otx2_reg.h"
> +#include "rep.h"
> +
> +#define DRV_NAME       "rvu_rep"
> +#define DRV_STRING     "Marvell RVU Representor Driver"
> +
> +static const struct pci_device_id rvu_rep_id_table[] =3D {
> +       { PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, PCI_DEVID_RVU_REP) },
> +       { }
> +};
> +
> +MODULE_AUTHOR("Marvell International Ltd.");
> +MODULE_DESCRIPTION(DRV_STRING);
> +MODULE_LICENSE("GPL");
> +MODULE_DEVICE_TABLE(pci, rvu_rep_id_table);
> +
> +static int rvu_rep_rsrc_free(struct otx2_nic *priv)
[Kalesh] You can change this to a void function
> +{
> +       struct otx2_qset *qset =3D &priv->qset;
> +       int wrk;
> +
> +       for (wrk =3D 0; wrk < priv->qset.cq_cnt; wrk++)
> +               cancel_delayed_work_sync(&priv->refill_wrk[wrk].pool_refi=
ll_work);
> +       devm_kfree(priv->dev, priv->refill_wrk);
> +
> +       otx2_free_hw_resources(priv);
> +       otx2_free_queue_mem(qset);
> +       return 0;
> +}
> +
> +static int rvu_rep_rsrc_init(struct otx2_nic *priv)
> +{
> +       struct otx2_qset *qset =3D &priv->qset;
> +       int err =3D 0;
[Kalesh] No need to initialize "rc" here
> +
> +       err =3D otx2_alloc_queue_mem(priv);
> +       if (err)
> +               return err;
> +
> +       priv->hw.max_mtu =3D otx2_get_max_mtu(priv);
> +       priv->tx_max_pktlen =3D priv->hw.max_mtu + OTX2_ETH_HLEN;
> +       priv->rbsize =3D ALIGN(priv->hw.rbuf_len, OTX2_ALIGN) + OTX2_HEAD=
_ROOM;
> +
> +       err =3D otx2_init_hw_resources(priv);
> +       if (err)
> +               goto err_free_rsrc;
> +
> +       /* Set maximum frame size allowed in HW */
> +       err =3D otx2_hw_set_mtu(priv, priv->hw.max_mtu);
> +       if (err) {
> +               dev_err(priv->dev, "Failed to set HW MTU\n");
> +               goto err_free_rsrc;
> +       }
> +       return 0;
> +
> +err_free_rsrc:
> +       otx2_free_hw_resources(priv);
> +       otx2_free_queue_mem(qset);
> +       return err;
> +}
> +
> +static int rvu_get_rep_cnt(struct otx2_nic *priv)
> +{
> +       struct get_rep_cnt_rsp *rsp;
> +       struct mbox_msghdr *msghdr;
> +       struct msg_req *req;
> +       int err, rep;
> +
> +       mutex_lock(&priv->mbox.lock);
> +       req =3D otx2_mbox_alloc_msg_get_rep_cnt(&priv->mbox);
> +       if (!req) {
> +               mutex_unlock(&priv->mbox.lock);
> +               return -ENOMEM;
> +       }
> +       err =3D otx2_sync_mbox_msg(&priv->mbox);
> +       if (err)
> +               goto exit;
> +
> +       msghdr =3D otx2_mbox_get_rsp(&priv->mbox.mbox, 0, &req->hdr);
> +       if (IS_ERR(msghdr)) {
> +               err =3D PTR_ERR(rsp);
[Kalesh] "rsp" is not initialized here. Did you mean "err =3D PTR_ERR(msghd=
r);"?
> +               goto exit;
> +       }
> +
> +       rsp =3D (struct get_rep_cnt_rsp *)msghdr;
> +       priv->hw.tx_queues =3D rsp->rep_cnt;
> +       priv->hw.rx_queues =3D rsp->rep_cnt;
> +       priv->rep_cnt =3D rsp->rep_cnt;
> +       for (rep =3D 0; rep < priv->rep_cnt; rep++)
> +               priv->rep_pf_map[rep] =3D rsp->rep_pf_map[rep];
> +
> +exit:
> +       mutex_unlock(&priv->mbox.lock);
> +       return err;
> +}
> +
> +static int rvu_rep_probe(struct pci_dev *pdev, const struct pci_device_i=
d *id)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct otx2_nic *priv;
> +       struct otx2_hw *hw;
> +       int err;
> +
> +       err =3D pcim_enable_device(pdev);
> +       if (err) {
> +               dev_err(dev, "Failed to enable PCI device\n");
> +               return err;
> +       }
> +
> +       err =3D pci_request_regions(pdev, DRV_NAME);
> +       if (err) {
> +               dev_err(dev, "PCI request regions failed 0x%x\n", err);
> +               return err;
> +       }
> +
> +       err =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
> +       if (err) {
> +               dev_err(dev, "DMA mask config failed, abort\n");
> +               goto err_release_regions;
> +       }
> +
> +       pci_set_master(pdev);
> +
> +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
[Kalesh: goto err_release_regions; ??
> +       pci_set_drvdata(pdev, priv);
> +       priv->pdev =3D pdev;
> +       priv->dev =3D dev;
> +       priv->flags |=3D OTX2_FLAG_INTF_DOWN;
> +       priv->flags |=3D OTX2_FLAG_REP_MODE_ENABLED;
> +
> +       hw =3D &priv->hw;
> +       hw->pdev =3D pdev;
> +       hw->max_queues =3D OTX2_MAX_CQ_CNT;
> +       hw->rbuf_len =3D OTX2_DEFAULT_RBUF_LEN;
> +       hw->xqe_size =3D 128;
> +
> +       err =3D otx2_init_rsrc(pdev, priv);
> +       if (err)
> +               goto err_release_regions;
> +
> +       err =3D rvu_get_rep_cnt(priv);
> +       if (err)
> +               goto err_detach_rsrc;
> +
> +       err =3D rvu_rep_rsrc_init(priv);
> +       if (err)
> +               goto err_detach_rsrc;
> +
> +       return 0;
> +
> +err_detach_rsrc:
> +       if (priv->hw.lmt_info)
> +               free_percpu(priv->hw.lmt_info);
> +       if (test_bit(CN10K_LMTST, &priv->hw.cap_flag))
> +               qmem_free(priv->dev, priv->dync_lmt);
> +       otx2_detach_resources(&priv->mbox);
> +       otx2_disable_mbox_intr(priv);
> +       otx2_pfaf_mbox_destroy(priv);
> +       pci_free_irq_vectors(pdev);
> +err_release_regions:
> +       pci_set_drvdata(pdev, NULL);
> +       pci_release_regions(pdev);
> +       return err;
> +}
> +
> +static void rvu_rep_remove(struct pci_dev *pdev)
> +{
> +       struct otx2_nic *priv =3D pci_get_drvdata(pdev);
> +
> +       rvu_rep_rsrc_free(priv);
> +       otx2_detach_resources(&priv->mbox);
> +       if (priv->hw.lmt_info)
> +               free_percpu(priv->hw.lmt_info);
> +       if (test_bit(CN10K_LMTST, &priv->hw.cap_flag))
> +               qmem_free(priv->dev, priv->dync_lmt);
> +       otx2_disable_mbox_intr(priv);
> +       otx2_pfaf_mbox_destroy(priv);
> +       pci_free_irq_vectors(priv->pdev);
> +       pci_set_drvdata(pdev, NULL);
> +       pci_release_regions(pdev);
> +}
> +
> +static struct pci_driver rvu_rep_driver =3D {
> +       .name =3D DRV_NAME,
> +       .id_table =3D rvu_rep_id_table,
> +       .probe =3D rvu_rep_probe,
> +       .remove =3D rvu_rep_remove,
> +       .shutdown =3D rvu_rep_remove,
> +};
> +
> +static int __init rvu_rep_init_module(void)
> +{
> +       pr_info("%s: %s\n", DRV_NAME, DRV_STRING);
> +
> +       return pci_register_driver(&rvu_rep_driver);
> +}
> +
> +static void __exit rvu_rep_cleanup_module(void)
> +{
> +       pci_unregister_driver(&rvu_rep_driver);
> +}
> +
> +module_init(rvu_rep_init_module);
> +module_exit(rvu_rep_cleanup_module);
> +
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h b/drivers/n=
et/ethernet/marvell/octeontx2/nic/rep.h
> new file mode 100644
> index 000000000000..30cce17eb48b
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Marvell RVU REPRESENTOR driver
> + *
> + * Copyright (C) 2024 Marvell.
> + *
> + */
> +
> +#ifndef REP_H
> +#define REP_H
> +
> +#include <linux/pci.h>
> +
> +#include "otx2_reg.h"
> +#include "otx2_txrx.h"
> +#include "otx2_common.h"
> +
> +#define PCI_DEVID_RVU_REP      0xA0E0
> +
> +#define RVU_MAX_REP    OTX2_MAX_CQ_CNT
> +struct rep_dev {
> +       struct otx2_nic *mdev;
> +       struct net_device *netdev;
> +       u16 rep_id;
> +       u16 pcifunc;
> +};
> +
> +static inline bool is_rep_dev(struct pci_dev *pdev)
> +{
> +       return pdev->device =3D=3D PCI_DEVID_RVU_REP;
> +}
> +
> +#endif /* REP_H */
> --
> 2.25.1
>


--=20
Regards,
Kalesh A P

--0000000000001a9d190616391558
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
AQkEMSIEIHmHFcD01v9GiIZEVhiRJItqXi4eE6sLXHYOhuLZwqggMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQxNjE2MTgwM1owaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAHPqmEcA3p
iPQ3exy3vwafl4OwuFBIm/KxwUPRmrQn3TE/gJPl3baf5VQBHDlsDYBGK2tz/fYvdN0b4601G/Rk
DqgS+gb0eBKdjb8pyvFKVAuyC4Z4SemOTOrVwx2Ps7g7Vin1BDw/+OkmkdCmg+aLdsWaCmNI0vj6
MfFULQ6KAa7lkmDrYjt/inCboOIZC3bQKK4N+PiJfLUeiirkrkXsMMZt1x/p8S2e8bkRJK2EG7wU
M39KEd/VmbB4KVsoHDvgUFAyfvTeRCGQ3eshbxgUjaEaVr/cpOrMNvD7/9702t/Pv1JLEbc18RwH
b2d7VGqsIHAMDDT8YU4TTzA6DM0v
--0000000000001a9d190616391558--

