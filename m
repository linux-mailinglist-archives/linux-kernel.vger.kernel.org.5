Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402687CC5C5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344063AbjJQOS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344072AbjJQOSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:18:24 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C968AFA;
        Tue, 17 Oct 2023 07:18:22 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d9b2ca542e5so4669867276.3;
        Tue, 17 Oct 2023 07:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697552302; x=1698157102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NI422ZwFC+FZy06/SEvrLc/oafnXORoAgmBSlqnJCBc=;
        b=Bx00iSEXwiNeZqmkRDGxtzbT37p1q1OkyWBv+4hiWVqI0l+yUr/CghfwvqWIO0ci3D
         71FJJXGuC+dfIhCMW6dkoYZ3/8s49654nVVnoYRcZ4pZcQg/vmdhnkYhxC6j3WSS4xwV
         5eh/n+oYMqYBgwje7TAqwEq42xr6M/Zk5s0Xz3WEhaxxseBY5NaDF5G58F07t7roDGc9
         bQrmjKeFNPF7VRK1+IYK/090cDkhdPFVPUEAsTewLHxsPjKXuK3zWvKVWm4ZiUtGdgIc
         3asduiv+jVd2XO7QeRW0Exomrb8pEjNFTAVYFyuG7IW8qhEMErkmAnLc/XNIvayk4QdF
         JxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697552302; x=1698157102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NI422ZwFC+FZy06/SEvrLc/oafnXORoAgmBSlqnJCBc=;
        b=o/6WtuQ5sZRDx07V/lzwbGWAmvLMQRGxKK256jH+vy1MFMvViVDPYDOXWjgkO7geSj
         AM+jMf/BxzmAJaPeFAVivxZdrncv03hUQkBaXbda63yUqP8jA6g2Wji7RuP/Sba2z3vZ
         cw+gWROgLWRfEzR8apvNHCoi1V9QbIqhOzml8P9HXAfFSYGd6xztHsTc4UbSPnatAlhb
         SnTHrhTf77e6Yye/2YeQmj66GPVWdZRW0TCT7Ykd8oNTMEGdDiNGVzQtoAx6gI0VdCrA
         o1E1DfMcLtLnXPU8qBRHaMV+OSFUm+kK3scr0yGGp/3SXXU7zLgA+wxQLy+Y+BHh3qm3
         CiCQ==
X-Gm-Message-State: AOJu0Yzvhz54LrLc/hNjKynG1UEqxFs2lxP/Rj51AShwD+thAizv8P4A
        z0XyHKv25pMRJPSjQQgZ7zZ9mvB4+dJTBoasHdk=
X-Google-Smtp-Source: AGHT+IGV/cNOijgcyX6YbdaC3gix3tYgeDlyLmcozvJjGQPyfoC73JRgCPVyHX5pMQVaZ6seRvCciLzWohic8S0Q594=
X-Received: by 2002:a25:e689:0:b0:d9b:df08:811d with SMTP id
 d131-20020a25e689000000b00d9bdf08811dmr2272203ybh.32.1697552301876; Tue, 17
 Oct 2023 07:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231012060115.107183-1-hayatake396@gmail.com> <20231016152343.1fc7c7be@kernel.org>
In-Reply-To: <20231016152343.1fc7c7be@kernel.org>
From:   takeru hayasaka <hayatake396@gmail.com>
Date:   Tue, 17 Oct 2023 23:18:10 +0900
Message-ID: <CADFiAcKOKiTXFXs-e=WotnQwhLB2ycbBovqS2YCk9hvK_RH2uQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] ethtool: ice: Support for RSS settings to GTP
 from ethtool
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Harald Welte <laforge@gnumonks.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        osmocom-net-gprs@lists.osmocom.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub-san and Simon-san
Thank you for reviewing again!

> Reviewed-by: Simon Horman <horms@kernel.org>
Thanks;)

> Adding Willem, Pablo, and Harald to CC (please CC them on future
versions).

of course.  thanks!

> nit: please note that these are hex numbers,
     next value after 0x19 is 0x1a, not 0x20.

!!!!! I'm so embarrassed.... I will next version fix

> What gives me pause here is the number of flow sub-types we define
> for GTP hashing.
>
> My understanding of GTP is limited to what I just read on Wikipedia.
>
> IIUC the GTPC vs GTPU distinction comes down to the UDP port on
> which the protocol runs? Are the frames also different?
>
> I'm guessing UL/DL are uplink/downlink but what's EH?
>
> How do GTPU_V4_FLOW, GTPU_EH_V4_FLOW, GTPU_UL_V4_FLOW, and
> GTPU_DL_V4_FLOW differ?
>
> Key question is - are there reasonable use cases that you can think of
> for enabling GTP hashing for each one of those bits individually or can
> we combine some of them?

Firstly, what I want to convey is that the structure of each of these
packets is entirely different. Therefore, in terms of ethtool, since
packets with the same structure are considered a flow, I understand
that it is necessary to define such different things (I actually think
that the people at Intel are doing it that way).

Let me first explain the difference between GTPC and GTPU.
The UDP ports are different in GTPC and GTPU.
What's further different is that in the case of GTPC, GTPv2-C is used,
and in the case of GTPU, GTPv1-U is used, which are mainstream in
current mobile communications.

Especially the uniqueness of GTPC communication varies according to
the processing phase.
CSR (Create Session Request) starts processing from a state where TEID
is not included. Therefore, it is separated into cases where packets
have TEID and where they don=E2=80=99t.
Of course, there are cases where we want to specially process only the
communication without TEID, and just creating a session is one of the
more vulnerable parts of the mobile network.

EH stands for Extension Header.
This is the case with GTPU packets compatible with 5G. If it=E2=80=99s the
Flow Director, it reads a parameter related to QoS called QFI.
Without this, it is impossible to process GTPv1 packets compatible with 5G.
Furthermore, this Extension Header has parts where the shape differs
depending on UL/DL, which is called the PDU Session Container.

Specific use cases basically apply to services that terminate GTP itself.

The structure of processing in RSS with ethtool until now was to
select a fixed shape of packets and parameters of those packets to
perform RSS.
Conforming to this format is why it becomes so numerous.


2023=E5=B9=B410=E6=9C=8817=E6=97=A5(=E7=81=AB) 7:23 Jakub Kicinski <kuba@ke=
rnel.org>:

>
> Thanks for the v2!
>
> Adding Willem, Pablo, and Harald to CC (please CC them on future
> versions).
>
> On Thu, 12 Oct 2023 06:01:15 +0000 Takeru Hayasaka wrote:
> > diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.=
h
> > index f7fba0dc87e5..a2d4f2081cf3 100644
> > --- a/include/uapi/linux/ethtool.h
> > +++ b/include/uapi/linux/ethtool.h
> > @@ -2011,6 +2011,18 @@ static inline int ethtool_validate_duplex(__u8 d=
uplex)
> >  #define      IPV4_FLOW       0x10    /* hash only */
> >  #define      IPV6_FLOW       0x11    /* hash only */
> >  #define      ETHER_FLOW      0x12    /* spec only (ether_spec) */
> > +#define GTPU_V4_FLOW 0x13    /* hash only */
> > +#define GTPU_V6_FLOW 0x14    /* hash only */
> > +#define GTPC_V4_FLOW 0x15    /* hash only */
> > +#define GTPC_V6_FLOW 0x16    /* hash only */
> > +#define GTPC_TEID_V4_FLOW 0x17       /* hash only */
> > +#define GTPC_TEID_V6_FLOW 0x18       /* hash only */
> > +#define GTPU_EH_V4_FLOW 0x19 /* hash only */
> > +#define GTPU_EH_V6_FLOW 0x20 /* hash only */
>
> nit: please note that these are hex numbers,
>      next value after 0x19 is 0x1a, not 0x20.
>
> > +#define GTPU_UL_V4_FLOW 0x21 /* hash only */
> > +#define GTPU_UL_V6_FLOW 0x22 /* hash only */
> > +#define GTPU_DL_V4_FLOW 0x23 /* hash only */
> > +#define GTPU_DL_V6_FLOW 0x24 /* hash only */
> >  /* Flag to enable additional fields in struct ethtool_rx_flow_spec */
> >  #define      FLOW_EXT        0x80000000
> >  #define      FLOW_MAC_EXT    0x40000000
>
> What gives me pause here is the number of flow sub-types we define
> for GTP hashing.
>
> My understanding of GTP is limited to what I just read on Wikipedia.
>
> IIUC the GTPC vs GTPU distinction comes down to the UDP port on
> which the protocol runs? Are the frames also different?
>
> I'm guessing UL/DL are uplink/downlink but what's EH?
>
> How do GTPU_V4_FLOW, GTPU_EH_V4_FLOW, GTPU_UL_V4_FLOW, and
> GTPU_DL_V4_FLOW differ?
>
> Key question is - are there reasonable use cases that you can think of
> for enabling GTP hashing for each one of those bits individually or can
> we combine some of them?
>
> > @@ -2025,6 +2037,7 @@ static inline int ethtool_validate_duplex(__u8 du=
plex)
> >  #define      RXH_IP_DST      (1 << 5)
> >  #define      RXH_L4_B_0_1    (1 << 6) /* src port in case of TCP/UDP/S=
CTP */
> >  #define      RXH_L4_B_2_3    (1 << 7) /* dst port in case of TCP/UDP/S=
CTP */
> > +#define      RXH_GTP_TEID    (1 << 8) /* teid in case of GTP */
> >  #define      RXH_DISCARD     (1 << 31)
