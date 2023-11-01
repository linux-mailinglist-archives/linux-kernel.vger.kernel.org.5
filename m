Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A709D7DDC28
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 06:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344559AbjKAERG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 00:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjKAERF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 00:17:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F290FC
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 21:17:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269C5C433C8;
        Wed,  1 Nov 2023 04:17:01 +0000 (UTC)
Date:   Wed, 1 Nov 2023 00:16:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>
Subject: Re: [PATCH] eventfs: Process deletion of dentry more thoroughly
Message-ID: <20231101001659.1456b3d4@gandalf.local.home>
In-Reply-To: <20231101022553.GE1957730@ZenIV>
References: <20231031144703.71eef3a0@gandalf.local.home>
        <20231101022553.GE1957730@ZenIV>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2023 02:25:53 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> On Tue, Oct 31, 2023 at 02:47:03PM -0400, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > Looking at how dentry is removed via the tracefs system, I found that
> > eventfs does not do everything that it did under tracefs. The tracefs
> > removal of a dentry calls simple_recursive_removal() that does a lot more
> > than a simple d_invalidate().  
> 
> Umm...  Is there any reason not to use simple_recursive_removal() there?

Hmm, I may be able to (I'm still a newbie with understanding of the vfs).

I did it this way thinking that a dentry may exist in the children but not
at a higher level, but I don't think that can be the case. This creates
dentries and inodes dynamically when they are referenced. The eventfs_inode
maps to each directory (the files of a directory are created from the
information from the eventfs_inode).

My thought process for doing it this way was if a child created a dentry
but the parent did not. But I don't think that can happen, right? So all I
may need to do is to check if the ei->dentry exists for the ei that is
being deleted, and after marking it and all its children as "freed", I can
then call simple_recursive_removal() on the top ei->dentry if it exists, as
that will guarantee to get all the dentries of any of the children that
exist. Right?

-- Steve
