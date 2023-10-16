Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30BD7CB321
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 21:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjJPTGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 15:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjJPTGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 15:06:01 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D7195;
        Mon, 16 Oct 2023 12:05:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so8499919a12.0;
        Mon, 16 Oct 2023 12:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697483158; x=1698087958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aUBC0dv+bnXuW2GkrUwjanS9UomsolAQvc5I7gaJS3M=;
        b=XuAlRFnF4eX6ZAZMHiS9b8x0BM85XEs2ZQNkO1em5P7WCLVDd4fDArEdqdCo0g6Ego
         lJIzx6D2eFRg+pPfCWqIi6JFsVZwvKbdfGpM6QrB1DIFa81hY734xr5iLrZOqSHrlQHr
         akZEw3o2UacoqDyDAI7nCamGOzPlkTAtsgvN5Oauy4CwQ61Fk28l871iEaC8vVr/gaRg
         5C0VmPz0+9SVB3fkyvh3Tbb9uJoWfe+Zbx/W3z8n7Vlt+G/v1XjeQLBauvO9E0+LE+WW
         1XC7wCscZKsN/dmN2K9HF0WwsU1eGW7vQ/z/K4rf0NJdz1kVybewtMungXesbHY7UAx0
         U4sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697483158; x=1698087958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUBC0dv+bnXuW2GkrUwjanS9UomsolAQvc5I7gaJS3M=;
        b=OY8ix1h4ZZDMlFOIe/o2RzEhUQOnxwUTf5SnRZ5AIN2fSPpRO6RlDhUnt6r4h21zc2
         53SieWle5Z1rNm8qgrA2mX+fzPB74VrZp/iol3wuk5QCHruEVJlPH6E7nW6jBZVpRuZq
         XK/Q/jYg46skk2Ih5lEmMaIlfuiX8mkJZocFevw29lAkNf6GlhSV121KXJ3ftZMrTbJq
         vCp/rscBgFcyH/m+6nRrbb3LCJrqgK6L/lvTwOLZw0GDZ5bzaSSRHtoyzbM/d1Jt7A4c
         qOul43L8xoDr5QiPPw4sDt/sDlz2kJ2YDnmJVlZLgJth8PSKHvcXe9tsj4QVUyoP60yH
         n40A==
X-Gm-Message-State: AOJu0YyDERvLz8kumhI5z7AVFU2HvcdBFoS1D5PUl3i8mcxfAck+8mev
        bHCkHxxw7M+36Dnk3bO4K5Y=
X-Google-Smtp-Source: AGHT+IHkW401GgKF7H4m0E/5ZjjRdITV6zhu1jdrb+6+Rb7hzzVQnvJ7lUbneThjcnpoTHKIA4irKw==
X-Received: by 2002:a50:8a9b:0:b0:532:cae2:8dfc with SMTP id j27-20020a508a9b000000b00532cae28dfcmr140418edj.5.1697483157884;
        Mon, 16 Oct 2023 12:05:57 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id i29-20020a50871d000000b0053de19620b9sm314436edb.2.2023.10.16.12.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 12:05:57 -0700 (PDT)
Date:   Mon, 16 Oct 2023 22:05:55 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v3 1/2] net: dsa: Use conduit and user terms
Message-ID: <20231016190555.svp5rjtheogxlkzv@skbuf>
References: <20231013215251.152912-1-florian.fainelli@broadcom.com>
 <20231013215251.152912-1-florian.fainelli@broadcom.com>
 <20231013215251.152912-2-florian.fainelli@broadcom.com>
 <20231013215251.152912-2-florian.fainelli@broadcom.com>
 <20231016132334.b5pz7kw5oitk32z2@skbuf>
 <ea6918d3-7e8c-4e31-9efb-cb9f3360962a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea6918d3-7e8c-4e31-9efb-cb9f3360962a@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 09:41:35AM -0700, Florian Fainelli wrote:
> > > @@ -29,7 +29,7 @@ static inline int dsa_tag_protocol_overhead(const struct dsa_device_ops *ops)
> > >   	return ops->needed_headroom + ops->needed_tailroom;
> > >   }
> > > -static inline struct net_device *dsa_master_find_slave(struct net_device *dev,
> > > +static inline struct net_device *dsa_conduit_find_user(struct net_device *dev,
> > >   						       int device, int port)
> > 
> > Please adjust alignment.
> 
> checkpatch did not complain and my editor shows me the alignment appears to
> be proper, what am I missing?

I didn't realize that the length of "master-slave" is the same as that of "conduit-user",
sorry.

> > > diff --git a/net/dsa/tag_8021q.c b/net/dsa/tag_8021q.c
> > > index cbdfc392f7e0..71b26ae6db39 100644
> > > --- a/net/dsa/tag_8021q.c
> > > +++ b/net/dsa/tag_8021q.c
> > > @@ -468,10 +468,10 @@ struct sk_buff *dsa_8021q_xmit(struct sk_buff *skb, struct net_device *netdev,
> > >   }
> > >   EXPORT_SYMBOL_GPL(dsa_8021q_xmit);
> > > -struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *master,
> > > +struct net_device *dsa_tag_8021q_find_port_by_vbid(struct net_device *conduit,
> > >   						   int vbid)
> > 
> > Alignment.
> 
> Likewise.

My mistake, sorry.
