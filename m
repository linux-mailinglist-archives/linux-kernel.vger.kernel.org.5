Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEE07510A6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 20:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjGLSjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 14:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGLSjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:39:51 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58EF1BF3;
        Wed, 12 Jul 2023 11:39:50 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1D624141954;
        Wed, 12 Jul 2023 18:39:50 +0000 (UTC)
Received: from pdx1-sub0-mail-a292.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 45649141E19;
        Wed, 12 Jul 2023 18:39:49 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1689187189; a=rsa-sha256;
        cv=none;
        b=trG4d6vyE3kUlspIIUBkYvsYwltryL2JzaXBCSPbXehCdwQis66BskbUs/P0EDYFsw9HLZ
        PYV5WxJWUQyA9V42aqUly+y8/uzbDGuv0wNLtp+7/j1zUEtt0A/XI+o9j2HkNzX+KyEQZV
        aJKXZ0VGbpoD2bnPnkmlMCi1YO3/fAYl1MFHItXQCnLPx/NF5vrz6endVizfxsZQ6AAiyG
        ZIoqK5qACInmjXq977l4LVxCNjvbW4IXsBZAIIeRSV/WF9UiS0cS+D+0HEAE7i5cojMoAu
        0m7jIXmZU4LuWq2onvghZ8I7dpV1SzJweGa1YQiwvA9CwHmQLH5iUsFChEqB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1689187189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=f7+FobEjTOe2hEYFGOUooYlEshnkxlyBXA1c/2RM/iM=;
        b=1sYuA9JGNE+TIvYvUH0IEcKjisIWUg40XknNG1gCnhESzUv2j0S3ax+aGz70PXgGJK9d/r
        cL3OTV7ciZLuOe2wxe74rGqL8fRijq2etYNbpoelyREMg40BYxLht/kHSf1TUcdBPtpSpc
        1K4QB32VlSROvMJurianQOntN/WcMUJrwUaEV04+tQ/tBgcJKeG+vCzerIrV41pu5j5mlr
        W2A9NJhzrf4J0Jq0n2dsgMCSDMiYdTiord7qmo2/0kiltDDvC79J35jOBrQ9dDQekPdtWc
        QG04iEV2xuTEpujK5JT5j2G4RqIikAHvhtBCJiKVY6kI2kyzmPqH7EhHsuDe0g==
ARC-Authentication-Results: i=1;
        rspamd-7d9c4d5c9b-kprkf;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Belong-Invention: 4729f678329cebc6_1689187189628_3115873377
X-MC-Loop-Signature: 1689187189628:356198624
X-MC-Ingress-Time: 1689187189628
Received: from pdx1-sub0-mail-a292.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.120 (trex/6.9.1);
        Wed, 12 Jul 2023 18:39:49 +0000
Received: from offworld (unknown [104.36.30.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a292.dreamhost.com (Postfix) with ESMTPSA id 4R1RP024zjz7j;
        Wed, 12 Jul 2023 11:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1689187189;
        bh=f7+FobEjTOe2hEYFGOUooYlEshnkxlyBXA1c/2RM/iM=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=eDoydnw3ZL6ST7+0xpO4f1iyAru+ClO8cmKG8uuAZjqudiB/GZyWP+yiVSD/QuEnz
         A9hbAdSfQriC0AVGgEAjcMRHgjKi/no7A+oIQy0PyhlDaslRoHqjlOFnNao8MgOqQW
         RuzrwJfDJGw5W1D2E4K8Iz0WdKkw2Q9iF2jShpi6pm/bMR2ZXrA12Gv8lNFC/npMh7
         5cuTwQBMbuvwGjAVN8JvizvgWRUBZCa00p03fzU3rH7wxULCHlsxyaNl+v6JpYgOSc
         KszzxxT5VLfBGVL5WpHR+rFAXwxQae9seaU6Bpor+8Ji1oPUxwTbVmgBYEETJ3Xc4O
         aQ9RxNHOAYbtg==
Date:   Wed, 12 Jul 2023 11:03:23 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cxl/mem: Fix a double shift bug
Message-ID: <ljlzer7ao37l77ljmuhb7x7wpdl45a75xxins63wlg6n2hfuae@54gsbuo4qlcw>
References: <a11b0c78-4717-4f4e-90be-f47f300d607c@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a11b0c78-4717-4f4e-90be-f47f300d607c@moroto.mountain>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jul 2023, Dan Carpenter wrote:

>The CXL_FW_CANCEL macro is used with set/test_bit() so it should be a
>bit number and not the shifted value.  The original code is the
>equivalent of using BIT(BIT(0)) so it's 0x2 instead of 0x1.  This has
>no effect on runtime because it's done consistently and nothing else
>was using the 0x2 bit.
>
>Fixes: 9521875bbe00 ("cxl: add a firmware update mechanism using the sysfs firmware loader")
>Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
