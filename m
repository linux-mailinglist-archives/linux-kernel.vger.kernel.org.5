Return-Path: <linux-kernel+bounces-147918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBD08A7B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70F1C1C21A89
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EB541C73;
	Wed, 17 Apr 2024 04:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OQMcqfiK"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9AC41C7A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 04:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713327364; cv=none; b=sltghG8fnvfbXK4EZ2jHW8zOskReJYOYe9gVlGSjLQmynHIGJumhYufZvuHbDsdIs6Jv+BJlTeFjiqXDEM1W3GItviFH9ZjIA7P1Xys6dV0H+399u1XnLjQmEb733KclEUin4G0Z/jVFzZBFOrDEtIt+SFnFwmibC01+/4g+3dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713327364; c=relaxed/simple;
	bh=+cnAWxyDQ9nNlk8pIMTwKfKa2y6358sY3cvNOZyKRh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kg/hI2xXKrzUBDCuesqDni/mVkZJT9o+OB6MvdPChdOB9csRy2XOLjb1PZNc53rALW6vUu5nJK6QPOmu8rte8WH7zHA75wCbKFx26gKy/kiGz7gt4WzK5/HOE1ajKC9H6obI7o0RmcGrA1XtPOLOq4+6hfXq2H4/Rs2JmInmOXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OQMcqfiK; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d715638540so61463361fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1713327360; x=1713932160; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AVldltLXYV+v7PSAit9Jjrh4EMeeIsLCBpFKrrQyz6k=;
        b=OQMcqfiKifsrZ3/1Pf8pcuiVkaQgo+K7TV37SRu9/PskdJKToJGIBxg8cTJI5NdT5/
         8xXDJJ1ZnRnGlZaVdkb0CxgaV/WI18Jbq8zfLFgKlcBt6ewd1JxIH5M5rOiCBObSaCqU
         leCWQtebUyVbT9NP9YXeX5e2LbsB57n1+76Y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713327360; x=1713932160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVldltLXYV+v7PSAit9Jjrh4EMeeIsLCBpFKrrQyz6k=;
        b=QZ5pI5jrI3Pr+DdamepZKaP6Tr0uHPId+YqBBQpg/1n2zu69HBkTQrA0XZKy41i/hC
         qXVXkLxlFb9CwwNRE27p9V5v4/YMHunlP/rYwwti1uPC8Cy6N1QK5QYxv77+Oh3RHo4F
         ByEEtBp3t8pzual0+xHAYY++S05t/8oMZwxTwA2vwnCp0HJGGKgKdFRL9NdZND7qMlGo
         syNU+D1HMHgRaB7JQMFS9LR+PufcrMrWZSPMDKthGdQR32HoBDuBbYeRDKw2ysQopgiq
         soelnYdVhEwe1DkLc+FdAYvQiySMMVnj6N2vZ09fp6FyyH4y3+PB9bXxGWM1VgmTyfXP
         AeMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSXKQt6MzwsOETw46I3784zi6TWjnCUu0oDGaoxYhDiAS594j2UPQgql/CydppQjhkNQmlEOvCmWZYQvPoYA59HfDpEKSKUYKJX68v
X-Gm-Message-State: AOJu0YzugX3339XaPf7cr91tHZ8GmbxppzAfyzDvh9zsrg+rEAHBwwy4
	gfQsVXPAtoBs697ocQ/XZX1XEzSwIthZ2fkslqTssUR3Fzifc22OiuOw+LhY+afzSYJ5scTc28X
	CHiGfi/Y2p5b6cBnF9pH9WTuTz9dE/wCaA1wu
X-Google-Smtp-Source: AGHT+IHV2zZhj+okgvP+K9VLtJJTp5bv3Gv33kwZDiO3lSaJNTnoOD9jLRc9wt8FsHpemCHmB99p9Bm7p5Ip7s3BBPU=
X-Received: by 2002:a05:651c:93:b0:2d8:3e60:b9c9 with SMTP id
 19-20020a05651c009300b002d83e60b9c9mr8512297ljq.33.1713327359806; Tue, 16 Apr
 2024 21:15:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416050616.6056-1-gakula@marvell.com> <20240416050616.6056-6-gakula@marvell.com>
 <CAH-L+nP6uRY-b8Rjw_9M8rtMTD4sNUVLHszkYOYb+i9dw8kzFg@mail.gmail.com>
In-Reply-To: <CAH-L+nP6uRY-b8Rjw_9M8rtMTD4sNUVLHszkYOYb+i9dw8kzFg@mail.gmail.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 17 Apr 2024 09:45:48 +0530
Message-ID: <CAH-L+nOnrp8gZCEvUoUUgz7R4R8TzxgTwDtAtGjdM4+oMNTobA@mail.gmail.com>
Subject: Re: [net-next PATCH 5/9] octeontx2-af: Add packet path between
 representor and VF
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b0b0210616431cf4"

--000000000000b0b0210616431cf4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 9:40=E2=80=AFAM Kalesh Anakkur Purayil
<kalesh-anakkur.purayil@broadcom.com> wrote:
>
> On Tue, Apr 16, 2024 at 10:38=E2=80=AFAM Geetha sowjanya <gakula@marvell.=
com> wrote:
> >
> > This patch installs tcam rules to stree traffic representors
> > and VF when swicthdev mode is set. To support this a HW loopback
> > channel is reserved. Through this channel packet are routed
> > between representor and VFs. "ESW_CFG" mbox is defined to
> > notify AF for installing rules.
> >
> > Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> > ---
> >  .../net/ethernet/marvell/octeontx2/af/mbox.h  |   7 +
> >  .../net/ethernet/marvell/octeontx2/af/rvu.h   |   7 +-
> >  .../marvell/octeontx2/af/rvu_devlink.c        |   6 +
> >  .../ethernet/marvell/octeontx2/af/rvu_nix.c   |   7 +-
> >  .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 241 +++++++++++++++++-
> >  .../marvell/octeontx2/af/rvu_switch.c         |  18 +-
> >  .../net/ethernet/marvell/octeontx2/nic/rep.c  |  19 ++
> >  7 files changed, 297 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers=
/net/ethernet/marvell/octeontx2/af/mbox.h
> > index c77c02730cf9..3b36da28a8f4 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> > @@ -144,6 +144,7 @@ M(LMTST_TBL_SETUP,  0x00a, lmtst_tbl_setup, lmtst_t=
bl_setup_req,    \
> >  M(SET_VF_PERM,         0x00b, set_vf_perm, set_vf_perm, msg_rsp)      =
 \
> >  M(PTP_GET_CAP,         0x00c, ptp_get_cap, msg_req, ptp_get_cap_rsp)  =
 \
> >  M(GET_REP_CNT,         0x00d, get_rep_cnt, msg_req, get_rep_cnt_rsp)  =
 \
> > +M(ESW_CFG,             0x00e, esw_cfg, esw_cfg_req, msg_rsp)   \
> >  /* CGX mbox IDs (range 0x200 - 0x3FF) */                              =
 \
> >  M(CGX_START_RXTX,      0x200, cgx_start_rxtx, msg_req, msg_rsp)       =
 \
> >  M(CGX_STOP_RXTX,       0x201, cgx_stop_rxtx, msg_req, msg_rsp)        =
 \
> > @@ -1532,6 +1533,12 @@ struct get_rep_cnt_rsp {
> >         u64 rsvd;
> >  };
> >
> > +struct esw_cfg_req {
> > +       struct mbox_msghdr hdr;
> > +       u8 ena;
> > +       u64 rsvd;
> > +};
> > +
> >  struct flow_msg {
> >         unsigned char dmac[6];
> >         unsigned char smac[6];
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/=
net/ethernet/marvell/octeontx2/af/rvu.h
> > index 1d76d52d7a5d..c8572d79a968 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> > @@ -596,6 +596,7 @@ struct rvu {
> >         u16                     rep_pcifunc;
> >         int                     rep_cnt;
> >         u16                     *rep2pfvf_map;
> > +       u8                      rep_mode;
> >  };
> >
> >  static inline void rvu_write64(struct rvu *rvu, u64 block, u64 offset,=
 u64 val)
> > @@ -1025,7 +1026,7 @@ int rvu_ndc_fix_locked_cacheline(struct rvu *rvu,=
 int blkaddr);
> >  /* RVU Switch */
> >  void rvu_switch_enable(struct rvu *rvu);
> >  void rvu_switch_disable(struct rvu *rvu);
> > -void rvu_switch_update_rules(struct rvu *rvu, u16 pcifunc);
> > +void rvu_switch_update_rules(struct rvu *rvu, u16 pcifunc, bool ena);
> >  void rvu_switch_enable_lbk_link(struct rvu *rvu, u16 pcifunc, bool ena=
);
> >
> >  int rvu_npc_set_parse_mode(struct rvu *rvu, u16 pcifunc, u64 mode, u8 =
dir,
> > @@ -1039,4 +1040,8 @@ int rvu_mcs_flr_handler(struct rvu *rvu, u16 pcif=
unc);
> >  void rvu_mcs_ptp_cfg(struct rvu *rvu, u8 rpm_id, u8 lmac_id, bool ena)=
;
> >  void rvu_mcs_exit(struct rvu *rvu);
> >
> > +/* Representor APIs */
> > +int rvu_rep_pf_init(struct rvu *rvu);
> > +int rvu_rep_install_mcam_rules(struct rvu *rvu);
> > +void rvu_rep_update_rules(struct rvu *rvu, u16 pcifunc, bool ena);
> >  #endif /* RVU_H */
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/=
drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> > index 96c04f7d93f8..8a3b7fb61883 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
> > @@ -1464,6 +1464,9 @@ static int rvu_devlink_eswitch_mode_get(struct de=
vlink *devlink, u16 *mode)
> >         struct rvu *rvu =3D rvu_dl->rvu;
> >         struct rvu_switch *rswitch;
> >
> > +       if (rvu->rep_mode)
> > +               return -EOPNOTSUPP;
> > +
> >         rswitch =3D &rvu->rswitch;
> >         *mode =3D rswitch->mode;
> >
> > @@ -1477,6 +1480,9 @@ static int rvu_devlink_eswitch_mode_set(struct de=
vlink *devlink, u16 mode,
> >         struct rvu *rvu =3D rvu_dl->rvu;
> >         struct rvu_switch *rswitch;
> >
> > +       if (rvu->rep_mode)
> > +               return -EOPNOTSUPP;
> > +
> >         rswitch =3D &rvu->rswitch;
> >         switch (mode) {
> >         case DEVLINK_ESWITCH_MODE_LEGACY:
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/driv=
ers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> > index 4ef5bb7b337f..75d5c1bc00e1 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> > @@ -2738,7 +2738,7 @@ void rvu_nix_tx_tl2_cfg(struct rvu *rvu, int blka=
ddr, u16 pcifunc,
> >         int schq;
> >         u64 cfg;
> >
> > -       if (!is_pf_cgxmapped(rvu, pf))
> > +       if (!is_pf_cgxmapped(rvu, pf) && !is_rep_dev(rvu, pcifunc))
> >                 return;
> >
> >         cfg =3D enable ? (BIT_ULL(12) | RVU_SWITCH_LBK_CHAN) : 0;
> > @@ -4368,8 +4368,6 @@ int rvu_mbox_handler_nix_set_mac_addr(struct rvu =
*rvu,
> >         if (test_bit(PF_SET_VF_TRUSTED, &pfvf->flags) && from_vf)
> >                 ether_addr_copy(pfvf->default_mac, req->mac_addr);
> >
> > -       rvu_switch_update_rules(rvu, pcifunc);
> > -
> >         return 0;
> >  }
> >
> > @@ -5159,7 +5157,7 @@ int rvu_mbox_handler_nix_lf_start_rx(struct rvu *=
rvu, struct msg_req *req,
> >         pfvf =3D rvu_get_pfvf(rvu, pcifunc);
> >         set_bit(NIXLF_INITIALIZED, &pfvf->flags);
> >
> > -       rvu_switch_update_rules(rvu, pcifunc);
> > +       rvu_switch_update_rules(rvu, pcifunc, true);
> >
> >         return rvu_cgx_start_stop_io(rvu, pcifunc, true);
> >  }
> > @@ -5187,6 +5185,7 @@ int rvu_mbox_handler_nix_lf_stop_rx(struct rvu *r=
vu, struct msg_req *req,
> >         if (err)
> >                 return err;
> >
> > +       rvu_switch_update_rules(rvu, pcifunc, false);
> >         rvu_cgx_tx_enable(rvu, pcifunc, true);
> >
> >         return 0;
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/driv=
ers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> > index d07cb356d3d6..5c015e8dfbbe 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> > @@ -13,6 +13,246 @@
> >  #include "rvu.h"
> >  #include "rvu_reg.h"
> >
> > +static u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc)
> > +{
> > +       int id;
> > +
> > +       for (id =3D 0; id < rvu->rep_cnt; id++)
> > +               if (rvu->rep2pfvf_map[id] =3D=3D pcifunc)
> > +                       return id;
> > +       return -ENODEV;
> > +}
> > +
> > +static int rvu_rep_tx_vlan_cfg(struct rvu *rvu,  u16 pcifunc,
> > +                              u16 vlan_tci, int *vidx)
> > +{
> > +       struct nix_vtag_config req =3D {0};
> > +       struct nix_vtag_config_rsp rsp =3D {0};
[Kalesh] RCT order. Also I think {0} is not needed and you can just use {}
> > +       u64 etype =3D ETH_P_8021Q;
> > +       int err;
> > +
> > +       /* Insert vlan tag */
> > +       req.hdr.pcifunc =3D pcifunc;
> > +       req.vtag_size =3D VTAGSIZE_T4;
> > +       req.cfg_type =3D 0; /* tx vlan cfg */
> > +       req.tx.cfg_vtag0 =3D true;
> > +       req.tx.vtag0 =3D etype << 48 | ntohs(vlan_tci);
> > +
> > +       err =3D rvu_mbox_handler_nix_vtag_cfg(rvu, &req, &rsp);
> > +       if (err) {
> > +               dev_err(rvu->dev, "Tx vlan config failed\n");
> > +               return err;
> > +       }
> > +       *vidx =3D rsp.vtag0_idx;
> > +       return 0;
> > +}
> > +
> > +static int rvu_rep_rx_vlan_cfg(struct rvu *rvu, u16 pcifunc)
> > +{
> > +       struct nix_vtag_config req =3D {0};
> > +       struct nix_vtag_config_rsp rsp;
> > +
> > +       /* config strip, capture and size */
> > +       req.hdr.pcifunc =3D pcifunc;
> > +       req.vtag_size =3D VTAGSIZE_T4;
> > +       req.cfg_type =3D 1; /* rx vlan cfg */
> > +       req.rx.vtag_type =3D NIX_AF_LFX_RX_VTAG_TYPE0;
> > +       req.rx.strip_vtag =3D true;
> > +       req.rx.capture_vtag =3D false;
> > +
> > +       return rvu_mbox_handler_nix_vtag_cfg(rvu, &req, &rsp);
> > +}
> > +
> > +static int rvu_rep_install_rx_rule(struct rvu *rvu, u16 pcifunc,
> > +                                  u16 entry, bool rte)
> > +{
> > +       struct npc_install_flow_req req =3D { 0 };
> > +       struct npc_install_flow_rsp rsp =3D { 0 };
> > +       struct rvu_pfvf *pfvf;
> > +       u16 vlan_tci, rep_id;
> > +
> > +       pfvf =3D rvu_get_pfvf(rvu, pcifunc);
> > +
> > +       /* To stree the traffic from Representee to Representor */
[Kalesh] Typo. did you mean steer?
> > +       rep_id =3D (u16)rvu_rep_get_vlan_id(rvu, pcifunc);
> > +       if (rte) {
> > +               vlan_tci =3D rep_id | 0x1ull << 8;
> > +               req.vf =3D rvu->rep_pcifunc;
> > +               req.op =3D NIX_RX_ACTIONOP_UCAST;
> > +               req.index =3D rep_id;
> > +       } else {
> > +               vlan_tci =3D rep_id;
> > +               req.vf =3D pcifunc;
> > +               req.op =3D NIX_RX_ACTION_DEFAULT;
> > +       }
> > +
> > +       rvu_rep_rx_vlan_cfg(rvu, req.vf);
> > +       req.entry =3D entry;
> > +       req.hdr.pcifunc =3D 0; /* AF is requester */
> > +       req.features =3D BIT_ULL(NPC_OUTER_VID) | BIT_ULL(NPC_VLAN_ETYP=
E_CTAG);
> > +       req.vtag0_valid =3D true;
> > +       req.vtag0_type =3D NIX_AF_LFX_RX_VTAG_TYPE0;
> > +       req.packet.vlan_etype =3D ETH_P_8021Q;
> > +       req.mask.vlan_etype =3D ETH_P_8021Q;
> > +       req.packet.vlan_tci =3D vlan_tci;
> > +       req.mask.vlan_tci =3D 0xffff;
> > +
> > +       req.channel =3D RVU_SWITCH_LBK_CHAN;
> > +       req.chan_mask =3D 0xffff;
> > +       req.intf =3D pfvf->nix_rx_intf;
> > +
> > +       return rvu_mbox_handler_npc_install_flow(rvu, &req, &rsp);
> > +}
> > +
> > +static int rvu_rep_install_tx_rule(struct rvu *rvu, u16 pcifunc, u16 e=
ntry,
> > +                                  bool rte)
> > +{
> > +       struct npc_install_flow_req req =3D { 0 };
> > +       struct npc_install_flow_rsp rsp =3D { 0 };
> > +       struct rvu_pfvf *pfvf;
> > +       int vidx, err;
> > +       u16 vlan_tci;
> > +       u8 lbkid;
> > +
> > +       pfvf =3D rvu_get_pfvf(rvu, pcifunc);
> > +       vlan_tci =3D rvu_rep_get_vlan_id(rvu, pcifunc);
> > +       if (rte)
> > +               vlan_tci |=3D 0x1ull << 8;
> > +
> > +       err =3D rvu_rep_tx_vlan_cfg(rvu, pcifunc, vlan_tci, &vidx);
> > +       if (err)
> > +               return err;
> > +
> > +       lbkid =3D pfvf->nix_blkaddr =3D=3D BLKADDR_NIX0 ? 0 : 1;
> > +       req.hdr.pcifunc =3D 0; /* AF is requester */
> > +       if (rte) {
> > +               req.vf =3D pcifunc;
> > +       } else {
> > +               req.vf =3D rvu->rep_pcifunc;
> > +               req.packet.sq_id =3D vlan_tci;
> > +               req.mask.sq_id =3D 0xffff;
> > +       }
> > +
> > +       req.entry =3D entry;
> > +       req.intf =3D pfvf->nix_tx_intf;
> > +       req.op =3D NIX_TX_ACTIONOP_UCAST_CHAN;
> > +       req.index =3D (lbkid << 8) | RVU_SWITCH_LBK_CHAN;
> > +       req.set_cntr =3D 1;
> > +       req.vtag0_def =3D vidx;
> > +       req.vtag0_op =3D 1;
> > +       return rvu_mbox_handler_npc_install_flow(rvu, &req, &rsp);
> > +}
> > +
> > +int rvu_rep_install_mcam_rules(struct rvu *rvu)
> > +{
> > +       struct rvu_switch *rswitch =3D &rvu->rswitch;
> > +       u16 start =3D rswitch->start_entry;
> > +       struct rvu_hwinfo *hw =3D rvu->hw;
> > +       u16 pcifunc, entry =3D 0;
> > +       int pf, vf, numvfs;
> > +       int err, nixlf, i;
> > +       u8 rep;
> > +
> > +       for (pf =3D 1; pf < hw->total_pfs; pf++) {
> > +               if (!is_pf_cgxmapped(rvu, pf))
> > +                       continue;
> > +
> > +               pcifunc =3D pf << RVU_PFVF_PF_SHIFT;
> > +               rvu_get_nix_blkaddr(rvu, pcifunc);
> > +               rep =3D true;
> > +               for (i =3D 0; i < 2; i++) {
> > +                       err =3D rvu_rep_install_rx_rule(rvu, pcifunc, s=
tart + entry, rep);
> > +                       if (err)
> > +                               return err;
> > +                       rswitch->entry2pcifunc[entry++] =3D pcifunc;
> > +
> > +                       err =3D rvu_rep_install_tx_rule(rvu, pcifunc, s=
tart + entry, rep);
> > +                       if (err)
> > +                               return err;
> > +                       rswitch->entry2pcifunc[entry++] =3D pcifunc;
> > +                       rep =3D false;
> > +               }
> > +
> > +               rvu_get_pf_numvfs(rvu, pf, &numvfs, NULL);
> > +               for (vf =3D 0; vf < numvfs; vf++) {
> > +                       pcifunc =3D pf << RVU_PFVF_PF_SHIFT |
> > +                                 ((vf + 1) & RVU_PFVF_FUNC_MASK);
> > +                       rvu_get_nix_blkaddr(rvu, pcifunc);
> > +
> > +                       /* Skip installimg rules if nixlf is not attach=
ed */
> > +                       err =3D nix_get_nixlf(rvu, pcifunc, &nixlf, NUL=
L);
> > +                       if (err)
> > +                               continue;
> > +                       rep =3D true;
> > +                       for (i =3D 0; i < 2; i++) {
> > +                               err =3D rvu_rep_install_rx_rule(rvu, pc=
ifunc, start + entry, rep);
> > +                               if (err)
> > +                                       return err;
> > +                               rswitch->entry2pcifunc[entry++] =3D pci=
func;
> > +
> > +                               err =3D rvu_rep_install_tx_rule(rvu, pc=
ifunc, start + entry, rep);
> > +                               if (err)
> > +                                       return err;
> > +                               rswitch->entry2pcifunc[entry++] =3D pci=
func;
> > +                               rep =3D false;
> > +                       }
> > +               }
> > +       }
> > +       return 0;
> > +}
> > +
> > +void rvu_rep_update_rules(struct rvu *rvu, u16 pcifunc, bool ena)
> > +{
> > +       struct rvu_switch *rswitch =3D &rvu->rswitch;
> > +       struct npc_mcam *mcam =3D &rvu->hw->mcam;
[Kalesh: maintain RCT order
> > +       u32 max =3D rswitch->used_entries;
> > +       int blkaddr;
> > +       u16 entry;
> > +
> > +       if (!rswitch->used_entries)
> > +               return;
> > +
> > +       blkaddr =3D rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
> > +
[Kalesh] No need of a blank line here
> > +       if (blkaddr < 0)
> > +               return;
> > +
> > +       rvu_switch_enable_lbk_link(rvu, pcifunc, ena);
> > +       mutex_lock(&mcam->lock);
> > +       for (entry =3D 0; entry < max; entry++) {
> > +               if (rswitch->entry2pcifunc[entry] =3D=3D pcifunc)
> > +                       npc_enable_mcam_entry(rvu, mcam, blkaddr, entry=
, ena);
> > +       }
> > +       mutex_unlock(&mcam->lock);
> > +}
> > +
> > +int rvu_rep_pf_init(struct rvu *rvu)
> > +{
> > +       u16 pcifunc =3D rvu->rep_pcifunc;
> > +       struct rvu_pfvf *pfvf =3D rvu_get_pfvf(rvu, pcifunc);
> > +
> > +       set_bit(NIXLF_INITIALIZED, &pfvf->flags);
> > +       rvu_switch_enable_lbk_link(rvu, pcifunc, true);
> > +       rvu_rep_rx_vlan_cfg(rvu, pcifunc);
> > +       return 0;
[Kalesh] This function returns 0 unconditionally, maybe you can change
it to void?
> > +}
> > +
> > +int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
> > +                            struct msg_rsp *rsp)
> > +{
> > +       if (req->hdr.pcifunc !=3D rvu->rep_pcifunc)
> > +               return 0;
> > +
> > +       rvu->rep_mode =3D req->ena;
> > +
> > +       if (req->ena)
> > +               rvu_switch_enable(rvu);
> > +       else
> > +               rvu_switch_disable(rvu);
> > +
> > +       return 0;
[Kalesh] This function returns 0 unconditionally, maybe you can change
it to void?
> > +}
> > +
> >  int rvu_mbox_handler_get_rep_cnt(struct rvu *rvu, struct msg_req *req,
> >                                  struct get_rep_cnt_rsp *rsp)
> >  {
> > @@ -45,4 +285,3 @@ int rvu_mbox_handler_get_rep_cnt(struct rvu *rvu, st=
ruct msg_req *req,
> >         }
> >         return 0;
> >  }
> > -
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c b/d=
rivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
> > index ceb81eebf65e..268efb7c1c15 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
> > @@ -166,6 +166,8 @@ void rvu_switch_enable(struct rvu *rvu)
> >
> >         alloc_req.contig =3D true;
> >         alloc_req.count =3D rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs;
> > +       if (rvu->rep_mode)
> > +               alloc_req.count =3D alloc_req.count * 4;
> >         ret =3D rvu_mbox_handler_npc_mcam_alloc_entry(rvu, &alloc_req,
> >                                                     &alloc_rsp);
> >         if (ret) {
> > @@ -189,7 +191,12 @@ void rvu_switch_enable(struct rvu *rvu)
> >         rswitch->used_entries =3D alloc_rsp.count;
> >         rswitch->start_entry =3D alloc_rsp.entry;
> >
> > -       ret =3D rvu_switch_install_rules(rvu);
> > +       if (rvu->rep_mode) {
> > +               rvu_rep_pf_init(rvu);
> > +               ret =3D rvu_rep_install_mcam_rules(rvu);
> > +       } else {
> > +               ret =3D rvu_switch_install_rules(rvu);
> > +       }
> >         if (ret)
> >                 goto uninstall_rules;
> >
> > @@ -222,6 +229,9 @@ void rvu_switch_disable(struct rvu *rvu)
> >         if (!rswitch->used_entries)
> >                 return;
> >
> > +       if (rvu->rep_mode)
> > +               goto free_ents;
> > +
> >         for (pf =3D 1; pf < hw->total_pfs; pf++) {
> >                 if (!is_pf_cgxmapped(rvu, pf))
> >                         continue;
> > @@ -249,6 +259,7 @@ void rvu_switch_disable(struct rvu *rvu)
> >                 }
> >         }
> >
> > +free_ents:
> >         uninstall_req.start =3D rswitch->start_entry;
> >         uninstall_req.end =3D  rswitch->start_entry + rswitch->used_ent=
ries - 1;
> >         free_req.all =3D 1;
> > @@ -258,12 +269,15 @@ void rvu_switch_disable(struct rvu *rvu)
> >         kfree(rswitch->entry2pcifunc);
> >  }
> >
> > -void rvu_switch_update_rules(struct rvu *rvu, u16 pcifunc)
> > +void rvu_switch_update_rules(struct rvu *rvu, u16 pcifunc, bool ena)
> >  {
> >         struct rvu_switch *rswitch =3D &rvu->rswitch;
> >         u32 max =3D rswitch->used_entries;
> >         u16 entry;
> >
> > +       if (rvu->rep_mode)
> > +               return rvu_rep_update_rules(rvu, pcifunc, ena);
> > +
> >         if (!rswitch->used_entries)
> >                 return;
> >
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers=
/net/ethernet/marvell/octeontx2/nic/rep.c
> > index 187b00156bcd..1329617f8d6f 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> > @@ -28,6 +28,22 @@ MODULE_DESCRIPTION(DRV_STRING);
> >  MODULE_LICENSE("GPL");
> >  MODULE_DEVICE_TABLE(pci, rvu_rep_id_table);
> >
> > +static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
> > +{
> > +       struct esw_cfg_req *req;
> > +
> > +       mutex_lock(&priv->mbox.lock);
> > +       req =3D otx2_mbox_alloc_msg_esw_cfg(&priv->mbox);
> > +       if (!req) {
> > +               mutex_unlock(&priv->mbox.lock);
> > +               return -ENOMEM;
> > +       }
> > +       req->ena =3D ena;
> > +       otx2_sync_mbox_msg(&priv->mbox);
> > +       mutex_unlock(&priv->mbox.lock);
> > +       return 0;
> > +}
> > +
> >  static netdev_tx_t rvu_rep_xmit(struct sk_buff *skb, struct net_device=
 *dev)
> >  {
> >         struct rep_dev *rep =3D netdev_priv(dev);
> > @@ -170,6 +186,8 @@ static void rvu_rep_free_netdev(struct otx2_nic *pr=
iv)
> >
> >  void rvu_rep_destroy(struct otx2_nic *priv)
> >  {
> > +       /* Remove mcam rules */
> > +       rvu_eswitch_config(priv, false);
> >         rvu_rep_free_cq_rsrc(priv);
> >         rvu_rep_free_netdev(priv);
> >  }
> > @@ -221,6 +239,7 @@ int rvu_rep_create(struct otx2_nic *priv)
> >         if (err)
> >                 goto exit;
> >
> > +       rvu_eswitch_config(priv, true);
> >         return 0;
> >  exit:
> >         rvu_rep_free_netdev(priv);
> > --
> > 2.25.1
> >
> >
>
>
> --
> Regards,
> Kalesh A P



--=20
Regards,
Kalesh A P

--000000000000b0b0210616431cf4
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
AQkEMSIEIFJDHMt20oYcr9rHotZQY20H/oAk86UNbc7Nyo0cafzoMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQxNzA0MTYwMFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCvASfhUuRO
OB3izbyAJwRgEN3//iE1QhNnq0NbkgGoNOWl9YDOer6Y5zh2XE/K5qGvKKAsG7SMKlOsDbCln08o
1gFLgCEsg69n9c647gCw63Od14wMvTkgoU9fmJZ0l/ki9mgOUamPCCeJrSotZblV892qbcFAwC9Y
c0K/Gm00wKh7y6foi4i12sz9bKAkE6DlB/Pjohr1CpQBVfruTHpF68rRXXyaSNFJWZs6nv9jUPfl
I3D82fIjONACr+xiPUDpAcJ/5dZNBpbIXApB1AG4WR8gpclELtiRktu3n9jsM6AWgA+0t+fXPxHy
Z1ytiPpcNRWdDMCftRkb9xIJd96P
--000000000000b0b0210616431cf4--

