Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FDC7CE4C9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjJRRkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjJRRkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:40:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3573711B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:40:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F17C433C8;
        Wed, 18 Oct 2023 17:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697650816;
        bh=a4MNBzIoQraa+P47UnuWNFSqE8gtKcdSsgT0BnTe1Vs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YVvNKp1Gdiy4zquRwSNqkoqP9Y8U1CeEAVV8xmeElCyZ8nCupZmWYM7ZTz1xZB9dY
         8AHPqT+TI3kITYLP7q8ccjFQhl5JV9Bc9bjmAkXAEHYzrFH3pve6CqtbDbab8Bnnl6
         yeua8COeRAd6q1xaRDSLEgFDq1OkCzqHdXUlq6CcxFeAVmCICPR5MnkBm18/eiBt41
         8QYwyXm+zebSU3kSVNasCwuS+26jLzVO1PBQflcoYVqsHuyli5k4x7yd6eHqQ3+FrA
         jLTRGDCWrhp4z06IZP4FBWDo7gCM7ZJixinvMqNLCMPyUeDoFTldAABiA8VYmt/mUv
         au/6sQvEm84NQ==
Date:   Wed, 18 Oct 2023 10:40:15 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Harald Welte <laforge@gnumonks.org>
Cc:     takeru hayasaka <hayatake396@gmail.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        osmocom-net-gprs@lists.osmocom.org
Subject: Re: [PATCH net-next v2] ethtool: ice: Support for RSS settings to
 GTP from ethtool
Message-ID: <20231018104015.42b2465b@kernel.org>
In-Reply-To: <ZS-TfMKAxHLEiXBl@nataraja>
References: <20231012060115.107183-1-hayatake396@gmail.com>
        <20231016152343.1fc7c7be@kernel.org>
        <CADFiAcKOKiTXFXs-e=WotnQwhLB2ycbBovqS2YCk9hvK_RH2uQ@mail.gmail.com>
        <CADFiAcLiAcyqaOTsRZHex8g-wSBQjCzt_0SBtBaW3CJHz9afug@mail.gmail.com>
        <20231017164915.23757eed@kernel.org>
        <CADFiAc+OnpyNTXntZBkDAf+UfueRotqqWKg+BrApWcL=x_8vjQ@mail.gmail.com>
        <ZS-TfMKAxHLEiXBl@nataraja>
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

On Wed, 18 Oct 2023 10:12:44 +0200 Harald Welte wrote:
> > If we were to propose again, setting aside considerations specific to
> > Intel, I believe, considering the users of ethtool, the smallest units
> > should be gtpu4|6 and gtpc4|6.  
> 
> agreed.  Though I'm not entirely sure one would usually want to treat v4
> different from v6.  I'd assume they would usually both follow the same
> RSS scheme?

FWIW I had the same thought. But if we do add flow matching 
support for GTP one day we'll have to define a struct like
struct ethtool_tcpip4_spec, which means size of the address
matters?
