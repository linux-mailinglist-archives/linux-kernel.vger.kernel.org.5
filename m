Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1037D9AC9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346113AbjJ0OF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346093AbjJ0OFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:05:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA31D4C;
        Fri, 27 Oct 2023 07:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698415520; x=1729951520;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=j5QA2qOS1gB5A/qToSJm+3DvK0o2Ul47Gc43OEH4rmo=;
  b=bKkUWunhARIRYLcaW0wVnDk2LtzXXbTvQorBsmnTsNuB4/kgTBgmzyxU
   n242n/+U88Kh8xbFiJH3gAlCd/T+DIimvrW5kE52aMA0Ry7qAOqOT7jYa
   LsLTHKbJ2ANg3DAAX+AJH8vsrFeG4xyX0AWR6unYFYMTzQ+XywPBG707T
   cbWjySLrxeGRVK+YJYOyQR9Hmb7piCmsvq3Ov+RmteqFurFGOylrEZGqZ
   yyEYrNxWqOh/hTCRup41iO3xcFdjsBUnCD//LHB8PwoUI+s2LnOt6hjF1
   +VgCWG2gi2x2VY4nS8/7fyK7S0jkBIEMRQR7SV46HcBK6bARY+e95PAUy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="390637449"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="390637449"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 07:05:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="850246312"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="850246312"
Received: from scoltan-mobl.ger.corp.intel.com ([10.252.33.159])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 07:05:17 -0700
Date:   Fri, 27 Oct 2023 17:05:15 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     VAMSHI GAJJELA <vamshigajjela@google.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, manugautam@google.com,
        Subhash Jadavani <sjadavani@google.com>,
        Channa Kadabi <kadabi@google.com>
Subject: Re: [PATCH v3 3/3] serial: core: Update uart_poll_timeout() function
 to return unsigned long
In-Reply-To: <CAMTSyjpzrwnbzcjm1nO9Zi7sn7yOGb8sxMjEJGgZoQLgDCx99g@mail.gmail.com>
Message-ID: <3698d22b-857f-b6de-bf4a-913ac2317f46@linux.intel.com>
References: <20231026135628.2800617-1-vamshigajjela@google.com> <2023102712-frolic-bush-3d67@gregkh> <CAMTSyjpzrwnbzcjm1nO9Zi7sn7yOGb8sxMjEJGgZoQLgDCx99g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-136478428-1698415519=:2740"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-136478428-1698415519=:2740
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 27 Oct 2023, VAMSHI GAJJELA wrote:

> On Fri, Oct 27, 2023 at 12:13 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Oct 26, 2023 at 07:26:28PM +0530, Vamshi Gajjela wrote:
> > > From: VAMSHI GAJJELA <vamshigajjela@google.com>
> >
> > Please use lower case letters like I think you mean to?
> Sure, I will update.
> >
> > Also, where are patches 1/3 and 2/3 of this series?  I can't do anything
> > without them as well.
> 1/3 is dropped:
> https://lore.kernel.org/lkml/CAMTSyjqc118-by6LRHaSN7k8fOcR6K0kmYXdthPD7rqJuYOaVw@mail.gmail.com/
> 2/3 is a clean up:
> https://lore.kernel.org/lkml/CAMTSyjpiz_LVtVAzaNpD-xThtp6sKNy-Uvkr+CaH9b10VRYD9A@mail.gmail.com/
> for 2/3 waiting on response from Ilpo Järvinen

I didn't realize you were waiting for some input.

You can do that rename if you want. Now that I looked again that patch, I 
was considering that perhaps the local frame_time variable could also be 
dropped in that function.

-- 
 i.

--8323329-136478428-1698415519=:2740--
