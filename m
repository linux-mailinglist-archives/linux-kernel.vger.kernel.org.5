Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190C87CEC90
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 02:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjJSAGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 20:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSAGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 20:06:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B81106
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 17:06:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF6BC433C8;
        Thu, 19 Oct 2023 00:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697673968;
        bh=FewQDix5K2xzAqhEssDfKbDVEbx1s5sPncq91M85278=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gn3QZbYryeidX644ynsDuCfrmYPm2P5XG6htQ/pOT3DE3q8AMTNv9ptmyIome970B
         nC2jsZZByDg1FKnz6AyBJkvCXqHRCua1y+C4faqDnx1a6xuqRA6Zbyqwh0qRdzE6TH
         Z0QYkWuXRnlj38OUXIoz12qV/giPYe38FlDGGoFdfNQr6+Omgxyg51xRlNC42nT4Eu
         A+72j/DJ1U8w4xkqz9g2EQDoW1pDGt06vEev/lIS+5RQgk6v7k2GzC+Qm4dToazk6t
         YpmozOK/cditkAO773VxfnUwBLYxWslhsB6qWZ0ZdLhp+A6M0NJJStHto4HOcEeXIk
         P8eeM3NaDUncA==
Date:   Wed, 18 Oct 2023 17:06:05 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     <horms@kernel.org>, <linux-kernel@vger.kernel.org>,
        <pabeni@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <egallen@redhat.com>, <hgani@marvell.com>, <mschmidt@redhat.com>,
        <netdev@vger.kernel.org>, <sedara@marvell.com>,
        <vburru@marvell.com>, <vimleshk@marvell.com>
Subject: Re: [net-next PATCH v3] octeon_ep: pack hardware structure
Message-ID: <20231018170605.392efc0d@kernel.org>
In-Reply-To: <20231016092051.2306831-1-srasheed@marvell.com>
References: <20231016092051.2306831-1-srasheed@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 02:20:51 -0700 Shinas Rasheed wrote:
> Clean up structure defines related to hardware data to be
> attributed 'packed' in the code, as padding is not allowed
> by hardware.

Looks like the patch was marked as Changes Requested in pw.
I'm guessing it's because we generally discourage __packed.
It's better to add size asserts, e.g.:

static_assert(sizeof(struct octep_oq_desc_hw) == 16);

__packed also implies lack of alignment, which may force compiler 
to generate worse code.
