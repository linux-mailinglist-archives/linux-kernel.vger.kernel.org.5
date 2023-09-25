Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B814A7ADB6C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjIYPaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjIYPaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:30:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D4095
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695655814; x=1727191814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=+Dp1EC+YyI93N2FPXUVUMUI65E/O+u1P75sw4qUmP84=;
  b=ktbkg5U6+DZ6K/BIyHeV6zLGz7bUQRMoW1wRnv31a2D5DR3VcPBOID0t
   PruaVJHeZZ39+EBkkJdHu52shzl7Cj1Zz0CONwDBM5BSwKRGpNk7RyN6p
   Y2JiiD/kIKZK9vrcrWzu7CJfr6qVfdXMCxtx//MGIFwRQwnWfk6LxoygP
   Mh/2fDkRLtoRg6iGYJi9U2MLjl5NtzO2SyYzuxgSoP4C2wu8FvFYV7hQ1
   g2TSQQVvti+tCnR+XICSO29tYwzfMtDiapQMUlmEHOQxQ1hCLxnrN60GZ
   DVDS/MMm2raWqJCh74z0aCnKvh8d+UC1XIf2Ojl0s9vix6jrm4+NW9BRV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360661440"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="360661440"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:30:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="741956629"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="741956629"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:30:11 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     tglx@linutronix.de
Cc:     arjan@linux.intel.com, bp@alien8.de, chang.seok.bae@intel.com,
        linux-kernel@vger.kernel.org, nik.borisov@suse.com, x86@kernel.org,
        qiuxu.zhuo@intel.com
Subject: Re: Subject: [patch V3 08/30] x86/microcode/intel: Save the microcode only after a successful late-load
Date:   Mon, 25 Sep 2023 23:30:04 +0800
Message-Id: <20230925153004.54984-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230912065501.269244004@linutronix.de>
References: <20230912065501.269244004@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> ...
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> There are situations where the late microcode is loaded into memory, but is
> not applied:
> 
>   1) The rendevouz fails

s/rendevouz/rendezvous/

>   2) The microcode is rejected by the CPUs
> 
> If any of this happens then the pointer which was updated at firmware load
> time is stale and subsequent CPU hotplug operations either fail to update
> or create inconsistent microcode state.
> 
> Save the loaded microcode in a separate pointer from with the late load is
> attempted and when successful, update the hotplug pointer accordingly via a
> new micrcode_ops callback.

s/micrcode_ops/microcode_ops

> 
> Remove the pointless fallback in the loader to a microcode pointer which is
> never populated.
> ...
