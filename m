Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2AA7D02CB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346457AbjJSTvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjJSTvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:51:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9926ACA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:51:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F586C433C7;
        Thu, 19 Oct 2023 19:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697745069;
        bh=zmKyiXUw03PdyIG0l9m5rnG2yY3mAiEOaPgc0wFDN8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IDlcoXnC+v/L+LqFlXCtOMWMZkI/loh/Gnyl+S3J9VMidgUZG/CS37uRJmKD8NoYE
         g48Z1Tw7C62vixL1+yVHnnE1elOD0nCR1fvR+9ADIol0+IZwc2H8cqBM+2qH+fwqyS
         2NOItxcxQ0eTg0sKjOASRJn4TK8/HbZpcPOEv5EKCaKYA5LO4zPIx9KP1EmtrZxr0B
         L9nWEJp9tFIYRkji2lLxZFyf/juFWX/xnFxhIIUUyWtW8V3yFFKQNB6ZUrD2Gm3AV6
         ZkW5/xtlxni/+13DEBSBn42KYDVPxQhttsPFXV9znlJmwMRPxi3mKQ5wLS58yX0o61
         H3WqF17ua9ifw==
Date:   Thu, 19 Oct 2023 12:51:07 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     "horms@kernel.org" <horms@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        Haseeb Gani <hgani@marvell.com>,
        "mschmidt@redhat.com" <mschmidt@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Sathesh B Edara <sedara@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Vimlesh Kumar <vimleshk@marvell.com>
Subject: Re: [EXT] Re: [net-next PATCH v3] octeon_ep: pack hardware
 structure
Message-ID: <20231019125107.5acd7c1e@kernel.org>
In-Reply-To: <PH0PR18MB4734672BE30C49F09E2C7D65C7D4A@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20231016092051.2306831-1-srasheed@marvell.com>
        <20231018170605.392efc0d@kernel.org>
        <PH0PR18MB4734672BE30C49F09E2C7D65C7D4A@PH0PR18MB4734.namprd18.prod.outlook.com>
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

On Thu, 19 Oct 2023 18:46:09 +0000 Shinas Rasheed wrote:
> Since these structures represent how hardware expects data, there can
> be a lack of alignment.

Doesn't the host allocate at least most of those?
Therefore controlling the alignment?

> I'm afraid static asserting all the hardware data structures might
> force some compilers to fail?

C has structure packing rules which mean that in 99.9999% of the cases
none of your structs need explicit packing. For the 0.0001% of arches
breaking build is fine.

At least that's my guess, again, I wasn't the one who rejected the
patch. I just noticed it was dropped in patchwork and made a guess
based on past experience.
