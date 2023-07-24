Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A2A75FC69
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjGXQoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjGXQoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:44:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5C6E4F;
        Mon, 24 Jul 2023 09:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690217054; x=1721753054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lMaCEtlky6+G2Qml4d+2fh4hc1YJEldCNV0Yg/t8zMo=;
  b=MUF9/S8xziIrwYRyjOhgwsBoRPTDzG1pX+onfQlfJi+xWmOEjmx9cK5m
   UNP4JzrozE5LZSndxSnLkpwseVr5rDSrhtsqvpvsq93BPk2tOH6PcMwkR
   SI6yKOU4oY8VAH3ACL5l5d4/sroot2UocpWZkZjh4XQ5AjV30ShzNJ8IC
   TZsAJyhtuSR+aoWitfjSOMveuLMAhsjA/ByLnoTbWbrZI5KL+XOigGixD
   WheTQnf+XKzZxBxl6sw39mGtZwMmwC87ir19s3v5Ni2UR8bf6lRav2aPJ
   KIwQZ/2rbCHJorN2dBWhG2xwAs+WU/zyiEoXzLUK/B1AroVIM5p0eo0ww
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="370160610"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="370160610"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 09:44:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="791028212"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="791028212"
Received: from gionescu-mobl2.ger.corp.intel.com (HELO intel.com) ([10.252.34.175])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 09:44:10 -0700
Date:   Mon, 24 Jul 2023 18:44:07 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Auld <matthew.auld@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Fix an error handling path in
 igt_write_huge()
Message-ID: <ZL6qV615GmktUhMG@ashyti-mobl2.lan>
References: <7a036b88671312ee9adc01c74ef5b3376f690b76.1689619758.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a036b88671312ee9adc01c74ef5b3376f690b76.1689619758.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

> All error handling paths go to 'out', except this one. Be consistent and
> also branch to 'out' here.
> 
> Fixes: c10a652e239e ("drm/i915/selftests: Rework context handling in hugepages selftests")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Pushed to drm-intel-gt-next.

Thanks,
Andi
