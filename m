Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4583B7EAFD8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjKNM3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjKNM3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:29:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4194C13D;
        Tue, 14 Nov 2023 04:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699964975; x=1731500975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/yJPHD0JWAZGjixOiPU2UbAep1ug0nJDTNewYaan4VM=;
  b=AnCw2sj/zjEr0xzYXJ97u0z6LuM5qXXjgvqyxJBfKagpGOrbcyVD5gzR
   P+AV5cXI7SEY4jGvH48oj2gEPaVizUWBXCwM8hMz/oRQccvdh2khFFEjN
   C6aM18UpJ4aof+PCl4o85/5eYhmkkhbqZquO+/4FfrHcgA8Lv5MCix8rL
   fSKNdYhMFcyC5Yrpu4kBob02L9w5nOUdTrX3QMjmpMVponHioDZALtFsV
   gTvJJaXmXtTMmqF6OlJqwvqzA/7l+gn+lODbcjpqYVaoHS9HPgEvBxuzR
   jNvBcU53Ukju45cu2pkxNSEekKiakh/YZo9qph1Vwsi22122Hp/4R6MAY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="9283899"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="9283899"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 04:29:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="938077782"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="938077782"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 04:29:31 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 23D1111FB5E;
        Tue, 14 Nov 2023 14:29:28 +0200 (EET)
Date:   Tue, 14 Nov 2023 12:29:28 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] lib/vsprintf: Fix %pfwf when current node refcount
 == 0
Message-ID: <ZVNoKAHlb1CXnND7@kekkonen.localdomain>
References: <20231114110456.273844-1-herve.codina@bootlin.com>
 <ZVNZ63HdoRKT4IQ9@kekkonen.localdomain>
 <20231114124832.40d4ced4@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114124832.40d4ced4@bootlin.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herve,

On Tue, Nov 14, 2023 at 12:48:32PM +0100, Herve Codina wrote:
> Hi Sakari,
> 
> On Tue, 14 Nov 2023 11:28:43 +0000
> Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> 
> > > --- a/lib/vsprintf.c
> > > +++ b/lib/vsprintf.c
> > > @@ -2108,8 +2108,8 @@ char *fwnode_full_name_string(struct fwnode_handle *fwnode, char *buf,
> > >  {
> > >  	int depth;
> > >  
> > > -	/* Loop starting from the root node to the current node. */
> > > -	for (depth = fwnode_count_parents(fwnode); depth >= 0; depth--) {
> > > +	/* Loop starting from the root node to the parent of current node. */
> > > +	for (depth = fwnode_count_parents(fwnode); depth > 0; depth--) {
> > >  		struct fwnode_handle *__fwnode =
> > >  			fwnode_get_nth_parent(fwnode, depth);  
> > 
> > How about, without changing the loop:
> > 
> > 		/*
> > 		 * Only get a reference for other nodes, fwnode refcount
> > 		 * may be 0 here.
> > 		 */
> > 		struct fwnode_handle *__fwnode =
> > 			depth ? fwnode_get_nth_parent(fwnode, depth) : fwnode;
> > 
> > >  
> > > @@ -2121,6 +2121,16 @@ char *fwnode_full_name_string(struct fwnode_handle *fwnode, char *buf,
> > >  		fwnode_handle_put(__fwnode);  
> > 
> > And:
> > 
> > 		if (__fwnode != fwnode)
> > 			fwnode_handle_put(__fwnode);
> > 
> 
> Sure.
> I will just change to keep the both tests consistent.
> I mean test with depth or test with __fwnode != fwnode but avoid
> mixing them.
> 
> What do you think about testing using depth in all cases and so:
> 	if (depth)
> 		fwnode_handle_put(__fwnode);

I'd compare fwnodes as we're putting __fwnode since we've gotten a
reference to fwnodes different from fwnode. I don't have a strong opinion
on this though, up to you.

-- 
Regards,

Sakari Ailus
