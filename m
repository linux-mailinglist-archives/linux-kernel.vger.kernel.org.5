Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224B38134D4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573807AbjLNPdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573757AbjLNPdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:33:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E9D10F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:33:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1B7C433C7;
        Thu, 14 Dec 2023 15:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702568029;
        bh=3dRVPojxVarxqc+k64+h1j/nb68HVbqD8FQgiohBXbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XTdkSdM1sLzi4D/PSBmJ2eDH19Bmp4X+y6BgJ1F+GShGRM/Cw/ypKQnB9w8xbS4Xu
         CfX5oreZxh4gy08/z77Gy3aRf/0oHo1S1w0oZnvwEsfrfYcepS9/iwpPTNyn5Mtl2x
         HkAJlUHreRrUpbQiCjy1h/wWRPLQ19pRl+imLyBk=
Date:   Thu, 14 Dec 2023 16:33:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev
Subject: Re: [PATCH] driver core: Add a guard() definition for the
 device_lock()
Message-ID: <2023121456-violation-unthawed-3ae3@gregkh>
References: <170250854466.1522182.17555361077409628655.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170250854466.1522182.17555361077409628655.stgit@dwillia2-xfh.jf.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 03:02:35PM -0800, Dan Williams wrote:
> At present there are ~200 usages of device_lock() in the kernel. Some of
> those usages lead to "goto unlock;" patterns which have proven to be
> error prone. Define a "device" guard() definition to allow for those to
> be cleaned up and prevent new ones from appearing.
> 
> Link: http://lore.kernel.org/r/657897453dda8_269bd29492@dwillia2-mobl3.amr.corp.intel.com.notmuch
> Link: http://lore.kernel.org/r/6577b0c2a02df_a04c5294bb@dwillia2-xfh.jf.intel.com.notmuch
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Hi Greg,
> 
> I wonder if you might include this change in v6.7-rc to ease some patch
> sets alternately going through my tree and Andrew's tree. Those
> discussions are linked above. Alternately I can can just take it through
> my tree with your ack and the other use case can circle back to it in
> the v6.9 cycle.

Sure, I'll queue it up now for 6.7-final, makes sense to have it now for
others to build off of, and for me to fix up some places in the driver
core to use it as well.

> I considered also defining a __free() helper similar to __free(mutex),
> but I think "__free(device)" would be a surprising name for something
> that drops a lock. Also, I like the syntax of guard(device) over
> something like guard(device_lock) since a 'struct device *' is the
> argument, not a lock type, but I'm open to your or Peter's thoughts on
> the naming.

guard(device); makes sense to me, as that's what you are doing here, so
I'm good with it.

thanks,

greg k-h
