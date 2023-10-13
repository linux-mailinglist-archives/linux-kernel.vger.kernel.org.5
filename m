Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988DB7C868B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjJMNPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjJMNPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:15:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AB5CA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:15:35 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697202933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SkFG+3LyiNgprdYnBxxoNAJ5LTWjyrCvcaBrBUygRPY=;
        b=k8QvJEVPLl3+Wnza5ucCf/q5ANPBsfsS5q2DsJazrbN/aQ8GVelHKbK4ljsXFsEaww8Js+
        Gx7b2Hn1SweS9x4S8glDkXjTavztLwL96TRRLXUuJ9rsSfDwkSOM2RdBa6698Y829n8qnK
        AiXQhF6e2HmfsUhzqkdpNhUImJQLZ2i4ouS2jqhEbzPN4qfA2gaqwd0/KziCTuD/++NdG4
        JgGEuZjk60LgGg59Wcy4m680dMYCJRJX4RM26uaBpcAqnR+GC2r9E71oFe0Cjiz3uM9oEI
        JJCa29KRCm1VIfzjEgfggasJ+Pc6Y3IvA21xFg+gMlIzq2agfq7gaIZ45n3U/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697202933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SkFG+3LyiNgprdYnBxxoNAJ5LTWjyrCvcaBrBUygRPY=;
        b=nQ8Tz2nlT9mL2M40ty37s55aeQyrJjiWyBvPdOrgzP9V4Ph06yuoCq3iOEqG6Fd1nmHWN9
        bBa7RwJVhYSJapAQ==
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mm@kvack.org
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: Re: [PATCH v2] debugobjects: stop accessing objects after releasing
 spinlock
In-Reply-To: <20230925131359.2948827-1-andrzej.hajda@intel.com>
References: <20230925131359.2948827-1-andrzej.hajda@intel.com>
Date:   Fri, 13 Oct 2023 15:15:33 +0200
Message-ID: <87v8bak6iy.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25 2023 at 15:13, Andrzej Hajda wrote:
> After spinlock release object can be modified/freed by concurrent thread.
> Using it in such case is error prone, even for printing object state.

It cannot be freed. If that happens then the calling code will have an
UAF problem on the tracked item too.

If there is a concurrent modification then again, the calling code is
lacking serialization on the tracked object.

debugobject fundamentally relies on the call site being consistent
simply because it _cannot_ invoke the fixup callbacks with the hash
bucket lock held.

What's the actualy problem you are trying to solve here. The changelog
does not explain anything except of handwaving about modified/freed.

Thanks,

        tglx
