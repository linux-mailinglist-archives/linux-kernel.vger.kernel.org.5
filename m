Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2B27DBA24
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjJ3Mvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjJ3Mve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:51:34 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE37C2;
        Mon, 30 Oct 2023 05:51:32 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so7470927a12.3;
        Mon, 30 Oct 2023 05:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698670290; x=1699275090; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bwdRBZbCT8Bb3c6eN7LkCskdruKqPbFov+yv5OPGtT0=;
        b=ixeLiNlqi270MuG5H8aOXIm2nBY+odNvhDgZj1rlhKZA7Gy1FrxHA6UqIBV75Kcvh3
         qaQ7J+U+cE3HWvPG4xQo6W+R1sxJcTG0pgL9QvVv49Cb86D6MnG1HSw+zqLbxZvPMgNY
         1B9zo5cAyGWUgJvygTLRy7F0u2Z9A7VAKumPEABBGL2FFySaClXrNVnx0N/HyBxCM0hk
         7jgjPfGgUusvchiz86Th+ycZF39g/vS9Zpo/WOdGBUuHbK2wwYePhsJ18gr2W34UtKMT
         1QF/nsO6tlFbbZniHHrVThzcn3knnm7//JrzcZU/EgMQTC5A2s59Rg6UjpvcGLJmOVqD
         uhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698670290; x=1699275090;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bwdRBZbCT8Bb3c6eN7LkCskdruKqPbFov+yv5OPGtT0=;
        b=sxkSs1NLTqup+UsuZzTf6FOPTPM86iS7Bvb+YcPWGeGhksbsVp9T6WMP56T7idPjK2
         OzvcleiPERkln9neyQ3xDAKmUfWHny0wdLL8TmxsxU4XnpK2G/5utBAjUPNhftYbbfbA
         4JStogXBJZm9I6jY3zyplRXq2nZGdAcWncAOXW+ydZPQNV9t5+T/Z3sbkrZFHxS7+3mB
         nNZSSO+m89AW0eKbL8AO94Nr2Qz8ZakZvda2UBzO9vYzal4urVxjIGKtDeantvg8XzQm
         w3lcK4sd4JhJ5nESP1bEvwGWbofdOV99oxYAv8srqamcXSUOBsZZki8Ym4FSxRUOFPJ6
         rwlg==
X-Gm-Message-State: AOJu0YyU70pz9fCxq8SZi2H7G6JbNrXNyB5RtCevH0NAeMn0QfwlzTaa
        EVrwBTvBtIDwXGuX6OaVKJI=
X-Google-Smtp-Source: AGHT+IEDegdd3F2L6G4PD7PW0gYhigit544HH9eq87Ly8+Hsf45YlnSaJ+098PkZt75Bl2CP20smrg==
X-Received: by 2002:a05:6402:8c1:b0:53e:afc0:ea43 with SMTP id d1-20020a05640208c100b0053eafc0ea43mr8425263edz.4.1698670290238;
        Mon, 30 Oct 2023 05:51:30 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id q20-20020a50aa94000000b00522828d438csm6165680edc.7.2023.10.30.05.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 05:51:30 -0700 (PDT)
Date:   Mon, 30 Oct 2023 14:51:27 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dsa: tag_rtl4_a: Bump min packet size
Message-ID: <20231030125127.xccqwct3jgg6o2rl@skbuf>
References: <20231027-fix-rtl8366rb-v1-1-d565d905535a@linaro.org>
 <95f324af-88de-4692-966f-588287305e09@gmail.com>
 <CACRpkdbyMEqjW1a9oK-GM2_XL0famH1RgSXW-fQLszn9t9UhWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbyMEqjW1a9oK-GM2_XL0famH1RgSXW-fQLszn9t9UhWw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2023 at 04:38:04PM +0100, Linus Walleij wrote:
> On Fri, Oct 27, 2023 at 11:23 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
> > > It turns out that sometimes, but not always, small packets are
> > > dropped by the switch for no reason.
> >
> > And we are positive that the Ethernet MAC is also properly padding
> > frames before having them ingress the switch?
> 
> I don't fully follow, this code is the one adding the padding isn't it?
> Then the result is transmitted to the switch from the ethernet
> MAC (drivers/net/ethernet/cortina/gemini.c).
> 
> What am I getting wrong here...

What you are missing is that the existing padding done by rtl4a_tag_xmit()
shouldn't be normally needed except for exceptional cases.

Socket buffers smaller than ETH_ZLEN can be passed to any network
device, and it is expected that either the driver or the hardware pads
up to ETH_ZLEN automatically. Thus, the conduit driver should already
know that it needs to pad packets to ETH_ZLEN.

The exceptional cases are:
- This is a tail tag (not the case here), which by definition needs to
  be located at the end of the skb. If you first put the tag then let
  the conduit interface pad, then the tail tag is no longer at the tail.
  So in that case, DSA pads first in generic code - dsa_user_xmit().
- The switch must handle the case where, after stripping the DSA tag
  from a ETH_ZLEN sized packet coming from the CPU port, it re-pads the
  packet on user port egress. Some switches don't handle that properly,
  and thus, we have isolated __skb_put_padto() calls within certain
  tagging protocols which address just that case.

So, what Florian was asking is whether the conduit interface is not
doing its expected job properly. You clarified that the problem is big
rather than small packets, but we still need an explanation for the
existing __skb_put_padto() call, given that it seems that it was placed
there due to a misunderstanding rather than due to an explicit need for
an exceptional case.
