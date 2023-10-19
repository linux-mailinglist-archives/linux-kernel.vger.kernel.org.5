Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6877CFE74
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346087AbjJSPnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346364AbjJSPnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:43:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3D71FC1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697730148; x=1729266148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2oh5pmAgDCd2gtHRN+bxNVTY3NzlD1CeuvsiPYhNrM0=;
  b=fPJP5QNdPwDubZXSpLdx5s+tYxfSx5W4oolQIBtuEdbV36fwHoKmF73n
   H0nmizmYAeR5g7MHViIM36F18hhWMjIdqzXLJK6zMqUjY2r0nsQmq4bem
   BYKg9E74FeTDtlV9nIa/5WBJgwqC4+DkxjUiC5llNQbr7hzVDy9M/vn3n
   w+kswEQsJGgsLbeR0vdUeEktp1av2zY6Bq3XX2I9RwvpnPNHWmhECdUi8
   ym/X/IbId2Iu4uYNeOZe6LhCgIN/3VmsYwJxm2j4Wvfy8jvr5AtQGCs5+
   wCogPRXgozvoEjRygrFV8gP9SKCjzXAldzEXKoqzkQej+MJSn4Ya6fDio
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="386110789"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="386110789"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 08:42:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="930648762"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="930648762"
Received: from jiaminka-mobl1.gar.corp.intel.com (HELO intel.com) ([10.215.251.143])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 08:42:20 -0700
Date:   Thu, 19 Oct 2023 17:42:09 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Soumya Negi <soumya.negi97@gmail.com>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 1/2] staging: vme_user: Replace printk() with
 pr_*(),dev_*()
Message-ID: <ZTFOUdMrDUylwa6F@ashyti-mobl2.lan>
References: <cover.1697696951.git.soumya.negi97@gmail.com>
 <cad6da28b5f772957ced5b561b21b5d8c8204bc9.1697696951.git.soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cad6da28b5f772957ced5b561b21b5d8c8204bc9.1697696951.git.soumya.negi97@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 19, 2023 at 12:20:09AM -0700, Soumya Negi wrote:
> vme.c uses printk() to log messages. To improve and standardize message
> formatting, use logging mechanisms pr_err()/pr_warn() and
> dev_err()/dev_warn() instead. Retain the printk log levels of the
> messages during replacement.
> 
> Issue found by checkpatch.pl
> 
> Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>

Acked-by: Andi Shyti <andi.shyti@linux.intel.com> 

Andi
