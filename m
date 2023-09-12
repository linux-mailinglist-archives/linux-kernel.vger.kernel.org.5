Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F1C79CB90
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjILJVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbjILJVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:21:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1904CA9;
        Tue, 12 Sep 2023 02:21:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C5BED21857;
        Tue, 12 Sep 2023 09:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694510492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ZhigEvPzFDk/Sf/E+yoI9+eK/zEdWQpWelnYnakpQ4=;
        b=HJJg6v4NOQuteCXp0om7BO8es5V0N78VWcuVrW+K5+ScI1E3R+g4Fh9SXFzAXP/369Jm9Y
        Z8SozkqYHHA/9GnIknXo9DKI7Ol+luM5efOjN6uAhxNkWdWR98hk5suJ/8ZS2qucttM+bE
        FX4M3kYV/6/xxB0Z3RcuaStdWR/wI+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694510492;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ZhigEvPzFDk/Sf/E+yoI9+eK/zEdWQpWelnYnakpQ4=;
        b=jryCrq1LLCxeBXjNScBRjOT64DUYSmSCcah9U05nshYS8f8ADYkWiMh4/0Qhi2hTzGczih
        xmNXQK/cAIVwFNDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48A73139DB;
        Tue, 12 Sep 2023 09:21:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nY5cEJwtAGUTNgAAMHmgww
        (envelope-from <aherrmann@suse.de>); Tue, 12 Sep 2023 09:21:32 +0000
Date:   Tue, 12 Sep 2023 11:23:00 +0200
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
        Radu Rendec <rrendec@redhat.com>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Pu Wen <puwen@hygon.cn>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        stable@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] x86/cacheinfo: Set the number of leaves per CPU
Message-ID: <20230912092300.GI603@alberich>
References: <20230805012421.7002-1-ricardo.neri-calderon@linux.intel.com>
 <20230901065028.GG8103@alberich>
 <20230901075254.GH8103@alberich>
 <20230912032350.GA17008@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912032350.GA17008@ranerica-svr.sc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 08:23:50PM -0700, Ricardo Neri wrote:
> Hi Andreas,
> 
> Agreed. Testing is important. For the specific case of these patches, I
> booted CONFIG_PREEMPT_RT and !CONFIG_PREEMPT_RT kernels. Then I
>   a) Ensured that the splat reported in commit 5944ce092b97
>      ("arch_topology: Build cacheinfo from primary CPU") was not observed.
> 
>   b) Ensured that /sys/devices/system/cpu/cpuX/cache is present.
> 
>   c) Ensured that the contents /sys/devices/system/cpu/cpuX/cache is the
>      same before and after my patches.
> 
> I tested on the following systems: Intel Alder Lake, Intel Meteor
> Lake, 2-socket Intel Icelake server, 2-socket Intel Cascade Lake server,
> 2-socket Intel Skylake server, 4-socket Intel Broadwell server, 2-socket
> Intel Haswell server, 2-socket AMD Rome server, and 2-socket AMD Milan
> server.
> 
> Thanks and BR,
> Ricardo


Thanks for all the tests and info.

-- 
Regards,
Andreas

SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nürnberg, Germany
GF: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG Nürnberg)
