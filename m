Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7AA7F36BA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 20:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjKUTQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 14:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjKUTQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 14:16:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF638110;
        Tue, 21 Nov 2023 11:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700594159; x=1732130159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XcNHGE3mfkWpwt/actN7amxrbPAaFnHfr5Q3LoIXsAA=;
  b=Lp9ZT9B5wsuaWAEVS2DxjZNZQO87aiEVl4+v5557Jn+8ZZG/UIe8u6xW
   rd13w1tnZnLnNd4UiALWiwORyui2HPiDf0LdWm9sPw9pYHTR47J3aTT15
   A2aBtllTZJ2STsMov/qGQ7muGgZNCKLJE9HEjlL4A2DmAtrs+//05j5G4
   hyCtlFePg+3oUVvsDTqDuE04RhscXYFxF3vPfVA7tNjPn4lHPZoA4QuXY
   UfOGXeSSg2R492J/JUyqv5k/Ql22Cig4x+/HbKdrrDbUHv/wK1VjoO2Mb
   DD+argnhn/Y7H3h6P4Hp8fWajUqfSRx4Q1IQLEE09gLq6vvWcTqTE1xSI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="395831982"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="395831982"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 11:15:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="910555576"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="910555576"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 11:15:58 -0800
Date:   Tue, 21 Nov 2023 11:15:57 -0800
From:   Isaku Yamahata <isaku.yamahata@linux.intel.com>
To:     Binbin Wu <binbin.wu@linux.intel.com>
Cc:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com,
        hang.yuan@intel.com, tina.zhang@intel.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        isaku.yamahata@linux.intel.com
Subject: Re: [PATCH v17 020/116] KVM: TDX: create/destroy VM structure
Message-ID: <20231121191557.GI1109547@ls.amr.corp.intel.com>
References: <cover.1699368322.git.isaku.yamahata@intel.com>
 <997a92e4f667b497166ff8cc777ec8025b0f22bc.1699368322.git.isaku.yamahata@intel.com>
 <2a5a38d9-28e2-4718-b8fc-2b8f27610706@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a5a38d9-28e2-4718-b8fc-2b8f27610706@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2023 at 02:30:19PM +0800,
Binbin Wu <binbin.wu@linux.intel.com> wrote:

> > +static int tdx_reclaim_page(hpa_t pa)
> > +{
> > +	int r;
> > +
> > +	r = __tdx_reclaim_page(pa);
> > +	if (!r)
> > +		tdx_clear_page(pa);
> > +	return r;
> > +}
> > +
> > +static void tdx_reclaim_td_page(unsigned long td_page_pa)
> 
> This function is used to reclaim td control sturcture pages like TDCX,
> TDVPX,
> TDVPR. Should this function name be more specific?
> For me, it is a bit confusing.
> 
> Or maybe do "td page" have specific meaning referring to these control
> structures
> pages in TDX?

As they are control page, how about tdx_reclaim_control_page()?
-- 
Isaku Yamahata <isaku.yamahata@linux.intel.com>
