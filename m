Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B38F7CACC9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbjJPPBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbjJPPBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:01:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409C5E6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:01:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA23C433C8;
        Mon, 16 Oct 2023 15:01:37 +0000 (UTC)
Date:   Mon, 16 Oct 2023 11:03:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Pekka Paalanen <ppaalanen@gmail.com>, jim.cromie@gmail.com,
        =?UTF-8?B?xYF1a2Fzeg==?= Bartosik <lb@semihalf.com>,
        linux-kernel@vger.kernel.org,
        "wayland-devel@lists.freedesktop.org" 
        <wayland-devel@lists.freedesktop.org>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v1] dynamic_debug: add support for logs destination
Message-ID: <20231016110312.3d18ea82@gandalf.local.home>
In-Reply-To: <ZSfCMBXOOi9Luc6F@phenom.ffwll.local>
References: <20231003155810.6df9de16@gandalf.local.home>
        <CAJfuBxyJyFbFEhRxrtxJ_RazaTODV6Gg64b1aiNEzt6_iE4=Og@mail.gmail.com>
        <CAK8ByeLNc9UbTNG4x=40AxYqjjRCsvBNtNFai0PMveM2X4XCow@mail.gmail.com>
        <CAJfuBxyRF4q_T8LmHwR=-PKKDDpiFg2nO03uLnL8aGpRyBByKw@mail.gmail.com>
        <CAK8ByeLpkSV6o6gPw8eJVqq5+ynQrSDjemY7mXkO1ZmA0rYKfQ@mail.gmail.com>
        <CAJfuBxw+ANLwssAGWpkn5PeJb8ZKn4LXQkk2Gfv3aGsSN=S55Q@mail.gmail.com>
        <CAJfuBxy9qn-4i3SteTL1LBbBxPrFM52KkBd=1UhcKV3S_KdQvw@mail.gmail.com>
        <20231011114816.19d79f43@eldfell>
        <ZSZuACLwt5_XAL2n@phenom.ffwll.local>
        <20231012115548.292fa0bb@eldfell>
        <ZSfCMBXOOi9Luc6F@phenom.ffwll.local>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 11:53:52 +0200
Daniel Vetter <daniel@ffwll.ch> wrote:

> > You said that turning the kernel ring buffer contents into strings is a
> > very heavy operation, so it is not possible to push this scope
> > separation to userspace, right?  
> 
> I think it's the kernel that does the formatting, but honestly not sure
> how this works with perf traces. Might be that it's actually userspace
> doing the formatting later on so that it doesn't incur the overhead while
> recording.

perf and trace-cmd do the formatting in user space via libtraceevent:

  git://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git

It reads the format files of the events:

  /sys/kernel/tracing/events/*/*/format

and uses that to read the raw data saved from the kernel into human
readable output.

Note, this means that addresses coming from kernel trace events are not
hashed!

-- Steve
