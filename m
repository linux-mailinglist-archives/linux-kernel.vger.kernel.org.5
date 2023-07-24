Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E327602E8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 01:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjGXXCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 19:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGXXCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 19:02:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C42E5C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 16:02:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62E6C6145F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 23:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E32C433C8;
        Mon, 24 Jul 2023 23:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690239735;
        bh=hI0FdL79ONz1aw2g1iC99scsQbNuHJWqIktK0q9d2t0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b3Hg0PnxsGfHyDxuZnH9oVhSo/fPlHoGpUlKPIo/KKCaqq9MmtD+6Wwx1991G8LX8
         fuPPoGWgcdApm3IY2/O19ElLmY3AudPAU0ErbNqhTY2mm5bPklUkMzbywOSKKDkvxr
         LUqDUQwAG5UEgQJZ3QCBaBai3U9nEaQZ1YO37cIBsbYmjX2tQDB0UyReM5GDBqAq5r
         oxol7DOgGyoRZVg2we88v/XRosM4QfAnMXE1rgeyqPXmPBrSia3VpfXSXS3AX43F7E
         idGRIi3yBoXdwqvAmRrpJsI+Z3Qv641aAP3UKXQ/6DvEm1mbsfVHq/r4re7u3QHojp
         5R0xPh7TVAyPA==
Date:   Mon, 24 Jul 2023 16:02:14 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net/sched: mqprio: Add length check for
 TCA_MQPRIO_{MAX/MIN}_RATE64
Message-ID: <20230724160214.424573ac@kernel.org>
In-Reply-To: <20230724014625.4087030-1-linma@zju.edu.cn>
References: <20230724014625.4087030-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2023 09:46:25 +0800 Lin Ma wrote:
> The nla_for_each_nested parsing in function mqprio_parse_nlattr() does
> not check the length of the nested attribute. This can lead to an
> out-of-attribute read and allow a malformed nlattr (e.g., length 0) to
> be viewed as 8 byte integer and passed to priv->max_rate/min_rate.
> 
> This patch adds the check based on nla_len() when check the nla_type(),
> which ensures that the length of these two attribute must equals
> sizeof(u64).

How do you run get_maintainer? You didn't CC the author of the code.
