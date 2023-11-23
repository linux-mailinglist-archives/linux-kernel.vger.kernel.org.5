Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB48B7F6156
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345756AbjKWOYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345739AbjKWOYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:24:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784B51BD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:24:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46714C433C8;
        Thu, 23 Nov 2023 14:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700749481;
        bh=J/LtgofwEQkoiVQZqoNXaJ9BMFsu3JjYY9qmjaMQE74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=myCexJJ1T1cKOvaXEHq4wweMQTiZAHJaQIpqITF2nz0OF3uoL1iwYojYKJkw4PYVR
         QfcDimY0ygH2HZrSIyCxQrHtsuFSlRQPO8OTFSPPOPD7jiDp1jBKsun38Rr4JNnKp/
         BmWkp+sMWRtw61zy6k1ytLqHhl3Q4c0zvaTAIWfuyGnDaFrnmulhvIfl/FxaSg01uJ
         vrKGenvAmwgayiPxnrogPgWdPV/BSA74uwa6+96sgKUQMzWHo9r/72hHKGaYMFypuP
         Tziu/KwbkQbvBfy4JH+YRTGybdW4tL5tlgZkmLy3GB1lSUmdmnybhceCeyVupWJV6p
         pdxhlPoo5kacQ==
Date:   Thu, 23 Nov 2023 14:24:35 +0000
From:   Simon Horman <horms@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Grant Grundler <grundler@chromium.org>,
        Edward Hill <ecgh@chromium.org>, linux-usb@vger.kernel.org,
        Laura Nao <laura.nao@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] r8152: Add RTL8152_INACCESSIBLE checks to more loops
Message-ID: <20231123142435.GG6339@kernel.org>
References: <20231117130836.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
 <20231117130836.2.I79c8a6c8cafd89979af5407d77a6eda589833dca@changeid>
 <4fa33b0938031d7339dbc89a415864b6d041d0c3.camel@redhat.com>
 <CAD=FV=VALvcLr+HbdvEen109qT3Z5EL0u4tiefTs3AH8EHXFnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=VALvcLr+HbdvEen109qT3Z5EL0u4tiefTs3AH8EHXFnA@mail.gmail.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 09:55:46AM -0800, Doug Anderson wrote:
> Hi,
> 
> On Tue, Nov 21, 2023 at 2:28 AM Paolo Abeni <pabeni@redhat.com> wrote:
> >
> > On Fri, 2023-11-17 at 13:08 -0800, Douglas Anderson wrote:
> > > Previous commits added checks for RTL8152_INACCESSIBLE in the loops in
> > > the driver. There are still a few more that keep tripping the driver
> > > up in error cases and make things take longer than they should. Add
> > > those in.
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >
> > I think this deserves a 'Fixes' tag. Please add it.
> 
> Sure, I can add it. It didn't feel worth it to me since there's no
> real functional issue--just that it takes a little longer for these
> loops to exit out, but it shouldn't hurt. I guess that means breaking
> this commit into several depending on when the offending loop was
> added.
> 
> 
> > Additionally please insert the target tree in the subj prefix when re-
> > postin (in this case 'net')
> 
> Funny, I just followed the tags for other commits to this file and the
> "net:" prefix isn't common. I guess this should be "net: usb: r8152".
> I can add it when I post v2.

Hi Doug,

unfortunately prefix can have more than one meaning here.
The target tree, often either net or net-next, should go
in the [] part of the subject.

In this case I think what you want is:

	[PATCH net n/m v2] Add RTL8152_INACCESSIBLE checks to more loops
