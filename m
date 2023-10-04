Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900507B7EE7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242315AbjJDMS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjJDMS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:18:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F3893
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:18:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7935DC433C7;
        Wed,  4 Oct 2023 12:18:54 +0000 (UTC)
Date:   Wed, 4 Oct 2023 08:20:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] tracing/timerlat: Hotplug support for the user-space
 interface
Message-ID: <20231004082001.104fce96@gandalf.local.home>
In-Reply-To: <20231004081731.141dfb99@gandalf.local.home>
References: <a1bbd57692c1a59458c4ee99999b7f83a29bc3c5.1695999408.git.bristot@kernel.org>
        <20231003210309.4335307d@gandalf.local.home>
        <3fbe67a4-225c-14c1-cb5a-3f667ad80b0e@kernel.org>
        <20231004081731.141dfb99@gandalf.local.home>
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

On Wed, 4 Oct 2023 08:17:31 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> #!/bin/bash
> 
> find_debugfs() {
>     debugfs=`cat /proc/mounts | while read mount dir type opts a b; do
> 	if [ $mount == "debugfs" ]; then

I guess I should update this to look for tracefs. This script is actually
older than tracefs.

-- Steve


> 	    echo $dir;
> 	    break
> 	fi
>     done`
>     if [ -z "$debugfs" ]; then
> 	if ! mount -t debugfs nodev /sys/kernel/debug; then
> 	    echo "FAILED to mount debugfs"
> 	    exit -1
> 	fi
> 	echo "/sys/kernel/debug"
>     else
> 	echo $debugfs
>     fi
> }
> 
> debugfs=`find_debugfs`
> tracedir="$debugfs/tracing"

