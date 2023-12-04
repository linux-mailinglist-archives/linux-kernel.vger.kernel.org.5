Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F42804054
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjLDUo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbjLDUoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:44:46 -0500
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5711C1713
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:43:16 -0800 (PST)
Date:   Mon, 4 Dec 2023 15:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701722594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iNxi9YFoE+NFrYyEyt9VqzHqEkE9JjNfNvXKaqpwd4g=;
        b=nl1NyELrv3nsiKkitJ33uf9fp/+L+jBXAGY1L1gWDkJrMYlkMS+08UGW2j/4gAbpK9KyRI
        0zbhh1uqzYxRKPCC1VX7ugX3IeAGsWvil9OC6pseWy5z5kdLlMtbB+8HOYSmqBVAJzRsVB
        RBJFfWpZaNJwHbDxRn57lvP1VUWZMwY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Donald Buczek <buczek@molgen.mpg.de>
Cc:     Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Krueger <stefan.krueger@aei.mpg.de>
Subject: Re: [bcachefs] [bug]: missing subvolume 0
Message-ID: <20231204204311.6mjsokq5z5uk6weg@moria.home.lan>
References: <5cc5076e-3a85-48e2-b75f-a3d1021f531e@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cc5076e-3a85-48e2-b75f-a3d1021f531e@molgen.mpg.de>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 12:03:26PM +0100, Donald Buczek wrote:
> Reporting to maintainer.pl list, hope that's correct?
> 
> Probably, this is a trivial one:
> Linux 6.7.0-rc4.
> 
> buczek@dose:~$ sudo bcachefs format /dev/vdb
> External UUID:                              d5181483-dc0c-4781-a266-ef830fa3c099
> Internal UUID:                              d96e4b19-43f3-4a5b-bc5c-3fe2b726b1ef
> [...]
> buczek@dose:~$ sudo bcachefs mount /dev/vdb /mnt
> buczek@dose:~$ sudo chmod a=rwxt /mnt
> buczek@dose:~$ mkdir /mnt/d
> buczek@dose:~$ bcachefs subvolume snapshot /mnt/d/snp1
> BCH_IOCTL_SUBVOLUME_CREATE ioctl error: No such file or directory
> buczek@dose:~$ dmesg|tail -10
> [ 7477.587299] bcachefs (vdb): mounting version 1.3: rebalance_work
> [ 7477.589134] bcachefs (vdb): recovering from clean shutdown, journal seq 14
> [ 7477.608861] bcachefs (vdb): alloc_read... done
> [ 7477.610525] bcachefs (vdb): stripes_read... done
> [ 7477.612037] bcachefs (vdb): snapshots_read... done
> [ 7477.644331] bcachefs (vdb): journal_replay... done
> [ 7477.645940] bcachefs (vdb): resume_logged_ops... done
> [ 7477.650087] bcachefs (vdb): going read-write
> [ 7514.113568] bcachefs (vdb): missing subvolume 0
> [ 7514.115121] bcachefs (vdb): inconsistency detected - emergency read only
> buczek@dose:~$

So the "no source argument" version is completely unimplemented, and I
never noticed - so thanks for the report :)

I'll have to disable that code path for now and get back to it when I'm
a bit less distracted, the patch so that we don't go -EROFS will go out
in the next bugfix pull request...
