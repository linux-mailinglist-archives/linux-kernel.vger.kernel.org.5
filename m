Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8A77AA686
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 03:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjIVB3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 21:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjIVB3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 21:29:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBF1D3;
        Thu, 21 Sep 2023 18:29:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7A8C433C8;
        Fri, 22 Sep 2023 01:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695346152;
        bh=b9gW9MIcyJlWGdZgvLY+dtieW9BAuI8bt7DipfXBSqI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u/GhEEGvLTbxweuNixKTTgDjLXMrk3GdhOT2YlQGOuMn0J57nwZW/iUTh5LG1nPGy
         X41WWqfXv+qtW3gZ0X+1O99Y+P4TQkx32/f5U2rcwzNEj028SHTPgpQZksqwgfY64v
         7+fJofXzg151864g5VRBhHehSL1X+l4VvZKPm0bA=
Date:   Thu, 21 Sep 2023 18:29:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        catalin.marinas@arm.com, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        david@redhat.com, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com, ayush.jain3@amd.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 4/6] mm: Make PR_MDWE_REFUSE_EXEC_GAIN an unsigned
 long
Message-Id: <20230921182910.2fcce58b27b23f767050033c@linux-foundation.org>
In-Reply-To: <20230828150858.393570-5-revest@chromium.org>
References: <20230828150858.393570-1-revest@chromium.org>
        <20230828150858.393570-5-revest@chromium.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 17:08:56 +0200 Florent Revest <revest@chromium.org> wrote:

> Defining a prctl flag as an int is a footgun because on a 64 bit machine
> and with a variadic implementation of prctl (like in musl and glibc),
> when used directly as a prctl argument, it can get casted to long with
> garbage upper bits which would result in unexpected behaviors.
> 
> This patch changes the constant to an unsigned long to eliminate that
> possibilities. This does not break UAPI.
> 
> Fixes: b507808ebce2 ("mm: implement memory-deny-write-execute as a prctl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Florent Revest <revest@chromium.org>
> Suggested-by: Alexey Izbyshev <izbyshev@ispras.ru>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Why is this being offered to -stable?  Does it fix any known problem?
