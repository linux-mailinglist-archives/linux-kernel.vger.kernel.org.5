Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CC479D6E7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbjILQyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237190AbjILQyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:54:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8C6D10E9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694537608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nc4+V5bh6p5NzLv7LF9hSohtp8QcmhcwlRvEw/hU9ug=;
        b=C8RoaxPedyOJVIci3rxGr0NcxzYXfyJYr78k3R10kP4ld/AIVCeeu84Sai69Q6vTge1WEB
        eMN4txJC0ZmEMC1zGJ25J5cRn0c/kYvQibn/Q/jqQhWx7TiSFPfMo6w2NVW78ZEnV4+fbq
        5tY4jNIQN+lNmPJeFIuoMOrdZSUNjBM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-nPFxylgbNPODCPeH_4FvAw-1; Tue, 12 Sep 2023 12:53:27 -0400
X-MC-Unique: nPFxylgbNPODCPeH_4FvAw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-501bef6b33aso966046e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694537606; x=1695142406;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nc4+V5bh6p5NzLv7LF9hSohtp8QcmhcwlRvEw/hU9ug=;
        b=U0AerdlfXq4FK8eu29pw4e8hI3lE7zrIx0j5bHTEILF7MUjcf+CBnJmapHudClY1VO
         zQF1hCD2GQSkQdgbwHVszON+wISux0eIrlB067DpDMADeTtBjtZYnx2OzPUl+tmREV4O
         OT4pw1X8jv7dgPbG13ssK9s2JUOtpbY6Cz1/4QsUzoUeVEqw4RAgPFAQ+ccDWDBbns4u
         iYzEP7jhvJ08ghpCqy9mkwjo9nCbStr5qYwHrH1i+HGYA6++ipjM014u/r3ndLVrUhfM
         rydvj06xROV6h9kJnR7e3QgYrfSzo/Nm51PCLHyR0CjVraEenQ+oai7h5GEqYKUovZxf
         KgPA==
X-Gm-Message-State: AOJu0YxfOPpYDI999DMMIglU0pB9tQTY47Z9ykbFVynFDDcD6Lzue8E1
        Aeb7NESx21I0npj26la3ziiqJqvbf2bOP1vyg9V6f5Y3feoBnDQyJqsQXfmSc5ub91r9kj+QMfX
        Ljb+hNhbuhQrfkhVZWwPWFCxQ
X-Received: by 2002:a05:6512:14b:b0:502:9b86:7112 with SMTP id m11-20020a056512014b00b005029b867112mr51056lfo.2.1694537605920;
        Tue, 12 Sep 2023 09:53:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB9zqEAtYNJs425Tw5xYK7xk5fDmDx97idivW9+AuMvyrKi8iFS4UnFeFpx5tOwp92xSj67w==
X-Received: by 2002:a05:6512:14b:b0:502:9b86:7112 with SMTP id m11-20020a056512014b00b005029b867112mr51049lfo.2.1694537605588;
        Tue, 12 Sep 2023 09:53:25 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-231.dyn.eolo.it. [146.241.249.231])
        by smtp.gmail.com with ESMTPSA id sb5-20020a170906edc500b009a1be9c29d7sm7177110ejb.179.2023.09.12.09.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 09:53:25 -0700 (PDT)
Message-ID: <20f57b1309b6df60b08ce71f2d7711fa3d6b6b44.camel@redhat.com>
Subject: Re: [PATCH net-next v1 2/2] net: core: Sort headers alphabetically
From:   Paolo Abeni <pabeni@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Simon Horman <horms@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Date:   Tue, 12 Sep 2023 18:53:23 +0200
In-Reply-To: <ZQCTXkZcJLvzNL4F@smile.fi.intel.com>
References: <20230911154534.4174265-1-andriy.shevchenko@linux.intel.com>
         <20230911154534.4174265-2-andriy.shevchenko@linux.intel.com>
         <20230912152031.GI401982@kernel.org> <ZQCTXkZcJLvzNL4F@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-12 at 19:35 +0300, Andy Shevchenko wrote:
> On Tue, Sep 12, 2023 at 05:20:31PM +0200, Simon Horman wrote:
> > On Mon, Sep 11, 2023 at 06:45:34PM +0300, Andy Shevchenko wrote:
> > > It's rather a gigantic list of heards that is very hard to follow.
> > > Sorting helps to see what's already included and what's not.
> > > It improves a maintainability in a long term.
> > >=20
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >=20
> > Hi Andy,
> >=20
> > At the risk of bike shedding, the sort function of Vim, when operating
> > with the C locale, gives a slightly different order, as experssed by
> > this incremental diff.
> >=20
> > I have no objections to your oder, but I'm slightly curious as
> > to how it came about.
>=20
> !sort which is external command.
>=20
> $ locale -k LC_COLLATE
> collate-nrules=3D4
> collate-rulesets=3D""
> collate-symb-hash-sizemb=3D1303
> collate-codeset=3D"UTF-8"

I'm unsure this change is worthy. It will make any later fix touching
the header list more difficult to backport, and I don't see a great
direct advantage.

Please repost the first patch standalone.

Thanks,

Paolo

