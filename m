Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AB37DC336
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 00:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjJ3XfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 19:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjJ3XfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 19:35:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BEFEA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:35:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA87C433C7;
        Mon, 30 Oct 2023 23:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698708904;
        bh=hd2BfLWW9jIL5aVaaeUWrJhmX9qwk5FbJl49+dTiq7g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IgEO6hmTH41lPqyNIim6WxiafeqqBggGNIdqN4H3Lrb2gTs7O0SqS5pzDPcGcW6ch
         hRDY3Jt0Vdt3wL0CE1H7SnsoKRYkQusXEtKpTwgXjbNfNEfPiSGnXHVTD26QMN5M8d
         GIk3L+IauOA1hL6V58j24UhlIC9XnGrZ7TbznhWDlkYA3RqjNr8JW4Fi66rqBVZ7La
         XWuoTErx9/8ee4XaeiP6jHbkx6h+NfZTTwXTxEw+dx/+3B6oOEPtuO3bAbWzX7tA44
         VM5iAorZen9KyL+nYZQ1/jVRV4jTNiFXfnlr7+19ITXLozKHoUCXCaICbxvWE6YHsg
         7rhfUf3HdNJBw==
Date:   Tue, 31 Oct 2023 08:35:00 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Tingwei Zhang <quic_tingweiz@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>
Subject: Re: How to pass software configuration to driver built as module in
 boot up phase
Message-Id: <20231031083500.343b39efded46acf1d349628@kernel.org>
In-Reply-To: <1c001c6f-9902-4803-9406-39e3325422bf@quicinc.com>
References: <1c001c6f-9902-4803-9406-39e3325422bf@quicinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 19:21:48 +0800
Tingwei Zhang <quic_tingweiz@quicinc.com> wrote:

> Hi Masami, Greg and Rafael,
> 
> I have one driver that needs a bunch to software configuration like 1000 
> settings. These settings can be different according to the use case.

Is it an out-of-tree driver which can not be embedded?

> 
> They are required in boot up phase so we can't reply on user space to 
> make the configuration.
> 
> Boot config is not preferred since we'd like to build that driver as 
> dynamic load Kernel module.
> 
> Could you let me know if there's any mechanism in Kernel to do that?

Hm, it is interesting situation. So I made the bootconfig API and data
released after boot (only keep it in /proc/bootconfig). So I thought
module loader script can parse it and pass params to the modules.
But I did not expected that the number of params is about 1000.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
