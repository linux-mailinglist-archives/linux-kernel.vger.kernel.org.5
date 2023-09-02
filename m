Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25E9790546
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 07:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351571AbjIBFav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 01:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345458AbjIBFau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 01:30:50 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB073180
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 22:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zpcuNBemwKhdVlTEYSSLaiBYpszJPZ71l/vhtjkuOsY=; b=Y/TZXjeo9OOsz2fA28zF9l/zjc
        AjThsX49wUSDSItKey1jotxIa24L9czAhjBfEIWsWb2rB+qHOA0npm+WnastiuhhWLpidXAzMzt9v
        ez9xZuFRQmN1ZGA7GMJ0yscE/9CMlOwAksmnbvZUDVeW6RQhjZBYNajgZmle2HjXAGIkbLrR9soXZ
        7YU6Yf5SCZbiezXg2E2v1Cq3fliH1Ez4fefQB/SeuXLWIVbTBQlDnJtfiBZl75M5nFkSz+Wp9gRVN
        OTo8itdX6uSPnKHPi+qzyE1y0f8SHaxGQUFD+BGe7f/r116Vaq8eXQ2tOZB6ZjMgy77ZKULBHOBSZ
        J/W6TS7Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qcJDY-002kuw-1c;
        Sat, 02 Sep 2023 05:30:44 +0000
Date:   Sat, 2 Sep 2023 06:30:44 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/25] ALSA: pcm: Add copy ops with iov_iter
Message-ID: <20230902053044.GJ3390869@ZenIV>
References: <20230815190136.8987-1-tiwai@suse.de>
 <20230815190136.8987-3-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815190136.8987-3-tiwai@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 09:01:13PM +0200, Takashi Iwai wrote:

> -	if (copy_from_user(get_dma_ptr(substream->runtime, channel, hwoff),
> -			   (void __user *)buf, bytes))
> +	if (!copy_from_iter(get_dma_ptr(substream->runtime, channel, hwoff),
> +			    bytes, iter))

The former is "if not everything got copied", the latter - "if nothing got
copied"; the same goes for other places like that.
