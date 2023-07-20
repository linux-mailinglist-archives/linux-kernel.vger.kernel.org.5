Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC7675BB27
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 01:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjGTX2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 19:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGTX17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 19:27:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DCAE42;
        Thu, 20 Jul 2023 16:27:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E422D61CB5;
        Thu, 20 Jul 2023 23:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE63C433C9;
        Thu, 20 Jul 2023 23:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689895677;
        bh=F/lLf6VoBWh6m+upBr0z/vTAwH2Fc7QsSDH7ZudA/xY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i2+QknZDMwRO3chfdCYhK1wlWzoPWWih6w72El36t7v8Z9I/q0n6Nq+dTw669e6hT
         K8dcTerAng0UPlEs6H5YpPAk964lhUzVPNtVkxZQuhPOuYjBsxSmWCC91v+Ge8ZX4i
         FTEDDFLks3n09elZ+GB1gzo3d3dWICekuHrtewPbcyhuQSdXmsGpEXKT1u29YLUcFK
         w8oI7+uBFFdnBFSQUKQLFbHdOokNkCsiKfHaSb3pvdHvSVzhbSo9/z6IJ7J33nhmZQ
         Z7iaHwI5wEik/M2so7YYgcXuP7dvpLotpm98c6jQc0NPvb6miADIeMaW5U73r6Xjw6
         /6XnkInEw3kEw==
Date:   Thu, 20 Jul 2023 16:27:56 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Networking <netdev@vger.kernel.org>,
        "Alexander Mikhalitsyn" <alexander@mihalicyn.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: linux-next: build failure after merge of the bluetooth tree
Message-ID: <20230720162756.08f2c66b@kernel.org>
In-Reply-To: <20230721081258.35591df7@canb.auug.org.au>
References: <PH0PR11MB51269B6805230AB8ED209B14D332A@PH0PR11MB5126.namprd11.prod.outlook.com>
        <20230720105042.64ea23f9@canb.auug.org.au>
        <20230719182439.7af84ccd@kernel.org>
        <20230720130003.6137c50f@canb.auug.org.au>
        <PH0PR11MB5126763E5913574B8ED6BDE4D33EA@PH0PR11MB5126.namprd11.prod.outlook.com>
        <20230719202435.636dcc3a@kernel.org>
        <20230720081430.1874b868@kernel.org>
        <20230721081258.35591df7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 08:12:58 +1000 Stephen Rothwell wrote:
> > I kicked it off and forgot about it.
> > allmodconfig on 352ce39a8bbaec04 (next-20230719) builds just fine :S  
> 
> Of course it does, as commit
> 
> 817efd3cad74 ("Bluetooth: hci_sock: Forward credentials to monitor")
> 
> is reverted in linux-next.  The question is "Does the bluetooth tree
> build?" or "Does the net-next tree build *if* you merge the bluetooth
> tree into it?"

Sorry for being slow, yes. I just did a test build with net-next and
bluetooth-next combined and allmodconfig is okay, so you should be good
to drop the revert. Fingers crossed.
