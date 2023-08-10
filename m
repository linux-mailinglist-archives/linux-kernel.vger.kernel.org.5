Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1258B7781BA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbjHJTmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjHJTmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:42:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AF62683
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691696489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SjLGJi3RZ2FKk2d3ScuHRczD0+DLJgOXpSTBakwEXCY=;
        b=dBDuvIuu+iUiZG1HCd0jLUbNaO7+syj7wHDzQUyNPbZOyjDKsrntUMFdVPYeyyFgm7V8ge
        w/2ifS0GbWtwdSXqgqD+LSd6IxEhJKfzyYIGxFi1a4zzvIaagpSBpoQ8Tj+e/C25GnD7cP
        TdYxjHNEEJ8Ooj7S0kOYfaTOdbgODUw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-nvRUW8YAMHqoZP4hiCnG0Q-1; Thu, 10 Aug 2023 15:41:28 -0400
X-MC-Unique: nvRUW8YAMHqoZP4hiCnG0Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fe19cf2796so8400285e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691696487; x=1692301287;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SjLGJi3RZ2FKk2d3ScuHRczD0+DLJgOXpSTBakwEXCY=;
        b=PjXE0U1pjMuh9P+mRD86ogMgDalJlZPHEcpMpYSV11jtq1T2cDJ03+7OwgEey1BCY7
         23z8mq/GDFb5a5Gzru0KHzJ6cijkJKFjuf3YT9DOM3XCVnlkHloOcfH2ld1vsBTsMIb8
         DkZ5IwU6kaAX0Va4nFkNcJ0Jmki03D7j56+o8LeF/haZ5gUfunwyOipXNR7/7gKSA0zp
         r84QM/uwm1png/aKLdpb8OilWBfVm8OwZVW2x2b5ZjGaK9zB4kP+E3M01nSwBsO4L7Hl
         Ti9rTAw33nc6oHXmCpdu2Vj+RrhaMpWL87A3rfRFcJTJtEmB/9+VgeNLWNCWWycqdO98
         6Rtg==
X-Gm-Message-State: AOJu0YwnEQYrC+kV7xTYSIq3xkMPmY3gk+1+h5gyuOAIrYKf96Te6eyk
        d9dzLO+692G0Z5XVyRYXqzdoDr4ZhbQ7CHwpcvNKk8mSOWgq9nmgKY8CQDPhC292oM4BXERGJC9
        9v7+VDckuK8jECjzsoMuyaWpP
X-Received: by 2002:a1c:f716:0:b0:3fc:92:73d6 with SMTP id v22-20020a1cf716000000b003fc009273d6mr2740465wmh.11.1691696487032;
        Thu, 10 Aug 2023 12:41:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1U/nfcisU1GAe+gXcGkGEXKKOPDNR8Kh/fdNV5Dl10o59b7VmDZSZgwpMeakhNHq8pJgijA==
X-Received: by 2002:a1c:f716:0:b0:3fc:92:73d6 with SMTP id v22-20020a1cf716000000b003fc009273d6mr2740454wmh.11.1691696486695;
        Thu, 10 Aug 2023 12:41:26 -0700 (PDT)
Received: from redhat.com ([2.55.42.146])
        by smtp.gmail.com with ESMTPSA id v2-20020a5d6102000000b003141e629cb6sm3022146wrt.101.2023.08.10.12.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:41:25 -0700 (PDT)
Date:   Thu, 10 Aug 2023 15:41:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Maxime Coquelin <maxime.coquelin@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Message-ID: <20230810153744-mutt-send-email-mst@kernel.org>
References: <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
 <20230725033506-mutt-send-email-mst@kernel.org>
 <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
 <20230726073453-mutt-send-email-mst@kernel.org>
 <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
 <20230727020930-mutt-send-email-mst@kernel.org>
 <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
 <20230727054300-mutt-send-email-mst@kernel.org>
 <CACGkMEvbm1LmwpiOzE0mCt6YKHsDy5zYv9fdLhcKBPaPOzLmpA@mail.gmail.com>
 <CACGkMEs6ambtfdS+X_9LF7yCKqmwL73yjtD_UabTcdQDFiF3XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEs6ambtfdS+X_9LF7yCKqmwL73yjtD_UabTcdQDFiF3XA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 10:30:56AM +0800, Jason Wang wrote:
> On Mon, Jul 31, 2023 at 2:30 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Thu, Jul 27, 2023 at 5:46 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Jul 27, 2023 at 04:59:33PM +0800, Jason Wang wrote:
> > > > > They really shouldn't - any NIC that takes forever to
> > > > > program will create issues in the networking stack.
> > > >
> > > > Unfortunately, it's not rare as the device/cvq could be implemented
> > > > via firmware or software.
> > >
> > > Currently that mean one either has sane firmware with a scheduler that
> > > can meet deadlines, or loses ability to report errors back.
> > >
> > > > > But if they do they can always set this flag too.
> > > >
> > > > This may have false negatives and may confuse the management.
> > > >
> > > > Maybe we can extend the networking core to allow some device specific
> > > > configurations to be done with device specific lock without rtnl. For
> > > > example, split the set_channels to
> > > >
> > > > pre_set_channels
> > > > set_channels
> > > > post_set_channels
> > > >
> > > > The device specific part could be done in pre and post without a rtnl lock?
> > > >
> > > > Thanks
> > >
> > >
> > > Would the benefit be that errors can be reported to userspace then?
> > > Then maybe.  I think you will have to show how this works for at least
> > > one card besides virtio.
> >
> > Even for virtio, this seems not easy, as e.g the
> > virtnet_send_command() and netif_set_real_num_tx_queues() need to
> > appear to be atomic to the networking core.
> >
> > I wonder if we can re-consider the way of a timeout here and choose a
> > sane value as a start.
> 
> Michael, any more input on this?
> 
> Thanks

I think this is just mission creep. We are trying to fix
vduse - let's do that for starters.

Recovering from firmware timeouts is far from trivial and
just assuming that just because it timed out it will not
access memory is just as likely to cause memory corruption
with worse results than an infinite spin.

I propose we fix this for vduse and assume hardware/firmware
is well behaved. Or maybe not well behaved firmware will
set the flag losing error reporting ability.



> >
> > Thanks
> >
> > >
> > >
> > > --
> > > MST
> > >

