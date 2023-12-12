Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E13D80E275
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345786AbjLLDDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 22:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjLLDDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 22:03:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD9C9C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 19:03:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F68C433C7;
        Tue, 12 Dec 2023 03:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702350186;
        bh=V6aKJvuenIIPeYtYC/2j963aubdSI2b0OSCD3ucQPBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hcOPdWevTHR2NUgEZZhGgvvqpu55ol3BkhpdrzGG8CV2x/D4T7pc0qj+dbicbmv2H
         vLbeHrFmJpv0oXlqhVynTTAoIBxZ0ySpvi6iBZjbxnSi2zodAwqHxXK32t7tTSRFkZ
         m/b4HDwsWJMH5nd/qRhdYByw8u7LDzJ8AaPlDuP5GW5Q8Cz6J9BpB3p7mk/rzMZVFm
         OSyR+HTdc9ejXom2U6xJTHNDsVhBFHkF7i3Upk1Qyvebz/CdPOqjYHCqC0m4KFk6BT
         1LVXuuFkiaKHRQwPvakKQd4oW6dZV+AQ6M9CtH7xhHkWWMRkZL7d5V2vynsX5Bk+X6
         cMoPE+6WfyVfA==
Date:   Mon, 11 Dec 2023 19:03:04 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Luis Henriques <lhenriques@suse.de>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] keys: flush work when accessing /proc/key-users
Message-ID: <20231212030304.GA39443@sol.localdomain>
References: <20231207024323.GA1994@sol.localdomain>
 <20231206145744.17277-1-lhenriques@suse.de>
 <498294.1701878642@warthog.procyon.org.uk>
 <87bkb3z047.fsf@suse.de>
 <2744563.1702303367@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2744563.1702303367@warthog.procyon.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 02:02:47PM +0000, David Howells wrote:
> Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > If there was a function that fully and synchronously releases a key's quota,
> > fs/crypto/ could call it before unlinking the key.  key_payload_reserve(key,
> > 0) almost does the trick, but it would release the key's bytes, not the key
> > itself.
> 
> Umm...  The point of the quota is that the key is occupying unswappable kernel
> memory (partly true in the case of big_key) and we need to limit that.
> Further, the key is not released until it is unlinked.

Well, fs/crypto/ no longer uses the keyrings subsystem for the actual keys, as
that was far too broken.  It just ties into the quota now.  So what's needed is
a way to release quota synchronously.

That might just mean not using the keyrings subsystem at all anymore.

> Do we need faster disposal of keys?  Perhaps keeping a list of keys that need
> destroying rather than scanning the entire key set for them.  We still need to
> scan non-destroyed keyrings, though, to find the pointers to defunct keys
> unless I have some sort of backpointer list.

If it's still asynchronous, that doesn't solve the problem.

- Eric
