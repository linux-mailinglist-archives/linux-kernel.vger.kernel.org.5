Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611737C7A70
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443101AbjJLXb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443085AbjJLXb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:31:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A965BE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:31:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CFEC433C8;
        Thu, 12 Oct 2023 23:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697153515;
        bh=X2cW1jO7AkWedt+NP/5hbxEdCkXpYElDX0uiLrNEZ6Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TdELZnP4C2cNeP4my3usuPDMBxevQ518KP+Kpi2kENZgmc2RuTuJSRhZpcyXobUmw
         zGChqXdSclqbb9m55X19lgGVrSWDkQBzPo3ni99jCzWquBzS7gOR5NmmtL678ZbNMF
         2YzWFZHxTlv9Xe9aCOFbHagxOuJLw/PqmgsqjPRMh8SbBMrGZCocql0ed0zzxwHyQx
         HZ+GxJRGa5o5WeW/QPqpKR0spZFLvAGSMc+T0CeZfDFSKBYy3fAl1OPWeGrGe+SGkF
         iXoBPMo+W2zUIh1z/IErL5kRcWpOATCf/aXg2su9jEYDMXIajvHncFn2EXOKERzIJZ
         k5manMJ0hr7lA==
Date:   Thu, 12 Oct 2023 16:31:53 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Michalik, Michal" <michal.michalik@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "Olech, Milena" <milena.olech@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Intel-wired-lan] [PATCH net-next 3/3] idpf: fix undefined
 reference to tcp_gro_complete() when !CONFIG_INET
Message-ID: <20231012163153.7fe61b40@kernel.org>
In-Reply-To: <CO1PR11MB508965D49B6144B0CC7E5221D6D3A@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20230920180745.1607563-1-aleksander.lobakin@intel.com>
        <20230920180745.1607563-4-aleksander.lobakin@intel.com>
        <2038f544-859f-4ffb-9840-37c1ba289259@infradead.org>
        <0df556eb-71b2-9612-a81d-cd83c27a2cd7@intel.com>
        <8eaece43-a30d-45e8-9610-28ed2af842fc@infradead.org>
        <b5c1030a-9831-4580-8684-7c68f5888131@infradead.org>
        <CO1PR11MB508965D49B6144B0CC7E5221D6D3A@CO1PR11MB5089.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 18:34:00 +0000 Keller, Jacob E wrote:
> > Even if this is just > v6.6 kernels (i.e., linux-next),
> > it would be very good to get a fix merged for these build errors.
> > I keep getting build errors in linux-next....
> 
> A standalone version for the idpf driver fix was posted at [1], and
> another alternative fix was posted at [2]
> 
> Fixes for the ice driver have already merged.
> 
> [1]:
> https://lore.kernel.org/netdev/20230921125936.1621191-1-aleksander.lobakin@intel.com/
> [2]:
> https://lore.kernel.org/netdev/20230925155858.651425-1-arnd@kernel.org/
> 
> The fix from Arnd got approval from Olek, but it seems like it
> stalled out after asking about stubs. I'm fine with either approach
> but would  also like to see a fix merge soon.

The suggestion of making NET == INET is quite tempting but requires
extra consideration. Since nobody seems to have the cycles, let's
go with the stubs?
