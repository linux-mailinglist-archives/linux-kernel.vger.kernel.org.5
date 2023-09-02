Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316AA790549
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 07:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351576AbjIBFgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 01:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243380AbjIBFgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 01:36:53 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD71180
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 22:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k+4m61B+T03hiC954QP7GIZExi9kv0zhekPgpjawNLA=; b=scBXjhLbYBOZaH7N/THyCiY+6L
        kCQlrczQODtFSUayXdP0gL3FV2flKOeSoHpX/up4VpcxSfAWJjttw+B9pDW42S8gUzBONdDtSRpf9
        mWaSf1iObrw0efiM3bXielVVq7C1u/Ti7IgJ+CXZPkCgW8hYKX6fPDEVHS5MSih/th6TfeoALLtRX
        yn3EtVcHY1DjfPPh90vz/L6adXrbjjCjAAh95/483aq0oHK+heFjfS4MiSqo1cNjRk1CfvY0o/bCa
        senv2C9z+L2ZZpBFnVZHAaWJe1Mduv4aE77+KO1istkR1ifgaHKiBx7XBkKNfvoiunWGcjKqTnnQI
        LyuYexqA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qcJJP-002kzQ-01;
        Sat, 02 Sep 2023 05:36:47 +0000
Date:   Sat, 2 Sep 2023 06:36:46 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/25] ALSA: emu8000: Convert to generic PCM copy ops
Message-ID: <20230902053646.GK3390869@ZenIV>
References: <20230815190136.8987-1-tiwai@suse.de>
 <20230815190136.8987-7-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815190136.8987-7-tiwai@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 09:01:17PM +0200, Takashi Iwai wrote:
> +		else if (copy_from_iter(&sval, 2, iter) != 2)		\
> +			return -EFAULT;					\

copy_from_iter_full()?

> -static int emu8k_pcm_copy_kernel(struct snd_pcm_substream *subs,
> -				 int voice, unsigned long pos,
> -				 void *src, unsigned long count)
> -{
> -	struct snd_emu8k_pcm *rec = subs->runtime->private_data;
> -
> -	/* convert to word unit */
> -	pos = (pos << 1) + rec->loop_start[voice];
> -	count <<= 1;
> -	LOOP_WRITE(rec, pos, src, count, COPY_KERNEL);
> +	LOOP_WRITE(rec, pos, src, count);
>  	return 0;
>  }
>  
> @@ -483,16 +456,15 @@ static int emu8k_pcm_silence(struct snd_pcm_substream *subs,
>  	/* convert to word unit */
>  	pos = (pos << 1) + rec->loop_start[voice];
>  	count <<= 1;
> -	LOOP_WRITE(rec, pos, NULL, count, FILL_SILENCE);
> +	LOOP_WRITE(rec, pos, USER_SOCKPTR(NULL), count);

USER_SOCKPTR?
