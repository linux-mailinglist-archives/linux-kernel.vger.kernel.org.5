Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A95976565B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbjG0Or4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjG0Orl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:47:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA6B3594;
        Thu, 27 Jul 2023 07:47:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BF5461E8A;
        Thu, 27 Jul 2023 14:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5834CC433CA;
        Thu, 27 Jul 2023 14:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690469220;
        bh=opLdqn7f8D0qGZiGDm9QU2lmGXhtxokrtarVA5rFFb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Te6nDSczd8N6IVTDn8sHxmnJntiGTiQvPxVOrk99FKyOigE92gvO660x9abTWcyee
         4cM7o4ZpSXfJycL+IZh/zzmHsmZTrZwspbjSMfrxguENmNsKakENwDbSxtk1iI6/f4
         ZYfq6BRetwtK75j5oBG9cV+sff79AIMgogZhIT1U=
Date:   Thu, 27 Jul 2023 16:46:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?Q?=C5=81ukasz?= Bartosik <lb@semihalf.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Subject: Re: [PATCH v1 1/2] thunderbolt: add tracefs support to tb_* logging
 helpers
Message-ID: <2023072705-palpitate-cut-874b@gregkh>
References: <20230727131326.2282301-1-lb@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230727131326.2282301-1-lb@semihalf.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 03:13:25PM +0200, Łukasz Bartosik wrote:
> Thunderbolt tracing is a lightweight alternative to traditional
> thunderbolt debug logging. While thunderbolt debug logging is quite
> convenient when reproducing a specific issue, it doesn't help when
> something goes wrong unexpectedly. There are a couple of reasons why
> one does not want to enable thunderbolt debug logging at all times:
> 
> 1. We don't want to overwhelm kernel log with thunderbolt spam, others
>    want to use it too

But doesn't the dynamic debug infrastructure allow this today?

> 2. Console logging is slow

Slow how?

> Thunderbolt tracing aims to solve both these problems. Use of
> the thunderbolt tracefs instance allows to enable thunderbolt
> logging in production without impacting performance or spamming
> the system logs.
> 
> To use thunderbolt tracing, set the thunderbolt.trace module parameter
> (via cmdline or sysfs) to true:
> ::
>   eg: echo true > /sys/module/thunderbolt/parameters/trace

Why yet-another module parameter?  Why is this required?

> Once active, all log messages will be written to the thunderbolt trace.
> Once at capacity, the trace will overwrite old messages with new ones.
> At any point, one can read the trace file to extract the previous
> thunderbolt messages:
> ::
>   eg: cat /sys/kernel/tracing/instances/thunderbolt/trace
> 
> The thunderbolt trace instance is subsystem wide, so if you have multiple
> devices active, they will be adding logs to the same trace.

This just uses the existing logging functionality and ties it into the
trace functionality, right?

If so, why not do this for all printk messages, why should this be
unique to thunderbolt?

Normally with tracing, you enable specific tracepoints that you add, not
just "all dev_*() messages", are you sure this will actually help?

thanks,

greg k-h
