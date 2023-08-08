Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F376F774153
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjHHRSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbjHHRSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:18:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B971E318
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510852; x=1723046852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=L0SzQV2CIzIJSKTK1+EaSq6DEeRnl6eW7zArOTckAmA=;
  b=ahBmCXjd38A7LAx9/9L3FWbV8DIaDDJFQMQdi3m7N8ZbH4tD+dUVDCwX
   jSu81rHc47NN0byYjFdgmJuEQtTP/wbLWSjdqk2mnug9FHOS6RYER6nlX
   8Jip5Br06A5TuX9lUmUySFrfUjCIs6sAcCD4a9wy1V+GzlAHrh/Ivka33
   RqCNQI+QrESFdWDI592RUPz3luyo+c5l8gjwFfUutCe0ijcMq3L2CDBVV
   /53jGFbNyW+QCJ5WE+SjSofxWy52UeKird4NLTLejaY9gDC/mtxH3n0UZ
   jfnV1LCVUY9Ze8xDXCzOqgiZm462bnKR+rH7BJyrOdi5ui7fTdQFigUOh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="351123432"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="351123432"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 06:34:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="766382011"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="766382011"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 06:34:11 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     tglx@linutronix.de
Cc:     andrew.cooper3@citrix.com, arjan@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        pbonzini@redhat.com, peter@keresztesschmidt.de,
        peterz@infradead.org, thomas.lendacky@amd.com, wei.liu@kernel.org,
        x86@kernel.org, qiuxu.zhuo@intel.com
Subject: Re: [patch V3 45/60] x86/apic: Sanitize APID ID range validation
Date:   Tue,  8 Aug 2023 21:34:07 +0800
Message-Id: <20230808133407.10901-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230801103817.624346203@linutronix.de>
References: <20230801103817.624346203@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

> From: Thomas Gleixner <tglx@linutronix.de>
> ...
> Subject: [patch V3 45/60] x86/apic: Sanitize APID ID range validation
> Now that everything has apic::max_apic_id set and the eventual update for
> the x2APIC case is in place, switch the apic_id_valid() helper to use
> apic::max_apic_id and remove the apic::apic_id_valid() callback.
> 

This patch removes default_apic_id_valid() and all references to it.
So may also need to remove the useless declaration of
"extern int default_apic_id_valid(u32 apicid)"
from arch/x86/include/asm/apic.h?

-Qiuxu

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ...
