Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD44761135
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjGYKsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjGYKsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:48:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A064B10FD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690282069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cJQzTxThR2VztifReyTpqJYEB15Fq8bQiVZuW+ew/e4=;
        b=Ps6i0Hongw5zRQxlfpS/s36YRDiPn33dLzAQekFIq0tMUKlyakRs99grAsXgyP+LGshL0q
        e5cBdSWGQ8tKz3l/qbw8NIlXxCyTZ/t0RWR3hC+mYCtRT4Aecfb10CcICMVLOTyxd4EOvB
        tcaCJ5FKTSgZx3v8EjlX/uKyz5iwnSo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-A9abvJDAMym7y0RRh0Ey5Q-1; Tue, 25 Jul 2023 06:47:48 -0400
X-MC-Unique: A9abvJDAMym7y0RRh0Ey5Q-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-403fcf7a9d0so14708661cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690282068; x=1690886868;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJQzTxThR2VztifReyTpqJYEB15Fq8bQiVZuW+ew/e4=;
        b=j692VsJ3+G6uyMU1PzFDKI4NJYpr6qUXi7oXbNPnFmOV6YYtSayRoiI87v5REMBfjY
         TU7TjuA/VyDfhyfnDaVSLk/SqpEydShpCv2WrnXiBxl+6HIfXDW3ylwztcn+K0c4iASt
         pygNSbXmcSe2MrtMsgVFW4esGW93Rcv9HkNiG+uReDGywJ7z3DBpgMsl6osZLJsPZ1C6
         iT5WmlxiVtaVKKkQZCktb575ml799LHVbDf1obPRbYE6rbI5j38K4aT2FabHGq+Lbupl
         kuw033STyab19xwl2uue+mblrSguCxzN+OBjY/BKdJtq3TVjuZDKBC3EMzcnXIvLek/6
         EAfw==
X-Gm-Message-State: ABy/qLbuqDYzCwg5XE7Uj6XtmqDM53OLeN/XIMRbSj+qDc3ThJP1JYTx
        FH8i9G1v6/LQ6zjkHj3AYqUFPIBxhS8TR6rjAzHgwQn5Q5RLaPZxkEpdX+WwLHVN8y2ehD+ptcb
        QL2L1EwZMTkW/PG5orGgWxDc4wDN+QwYe
X-Received: by 2002:a05:622a:1aaa:b0:403:b001:be3b with SMTP id s42-20020a05622a1aaa00b00403b001be3bmr16350738qtc.6.1690282067917;
        Tue, 25 Jul 2023 03:47:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFjHyvT827bv8a2AuTUh1x1s/iWAmW8Ra4YOQK6zvLyQFYP6favS5UMjBOH1c4Mx8EEHJuvTQ==
X-Received: by 2002:a05:622a:1aaa:b0:403:b001:be3b with SMTP id s42-20020a05622a1aaa00b00403b001be3bmr16350721qtc.6.1690282067601;
        Tue, 25 Jul 2023 03:47:47 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-81.dyn.eolo.it. [146.241.225.81])
        by smtp.gmail.com with ESMTPSA id a6-20020ac86106000000b0040697ea156asm1353597qtm.52.2023.07.25.03.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 03:47:47 -0700 (PDT)
Message-ID: <e1cdc94be0e515a5de9d4af8fccfd99e25435b73.camel@redhat.com>
Subject: Re: [PATCH net-next v3] net: dsa: mv88e6xxx: Add erratum 3.14 for
 88E6390X and 88E6190X
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ante Knezic <ante.knezic@helmholz.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
        f.fainelli@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        olteanv@gmail.com
Date:   Tue, 25 Jul 2023 12:47:43 +0200
In-Reply-To: <20230725095925.25121-1-ante.knezic@helmholz.de>
References: <30e262679bfdfd975c2880b990fe8375b9860aab.camel@redhat.com>
         <20230725095925.25121-1-ante.knezic@helmholz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding Russell]
On Tue, 2023-07-25 at 11:59 +0200, Ante Knezic wrote:
> On Tue, 25 Jul 2023 10:56:25 +0200 Paolo Abeni wrote
> > It looks like you are ignoring the errors reported by
> > mv88e6390_erratum_3_14(). Should the above be:
> >=20
> > 		return mv88e6390_erratum_3_14(mpcs);
> >=20
> > instead?
> >=20
>=20
> I guess you are right. Would it make sense to do the evaluation for the=
=20
> 	mv88e639x_sgmii_pcs_control_pwr(mpcs, true);
> above as well?

Good question ;) it looks like pcs_post_config() errors are always
ignored by the core, but I guess it's better to report them as
accurately as possible.

@Russell, what it your preference here, should we just ignore the
generate errors earlier, or try to propagate them to the core/phylink,
should that later be changed to deal with them?

Thanks,

Paolo

