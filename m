Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A6C75E5A4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 00:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjGWWpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 18:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjGWWpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 18:45:54 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D412E78
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 15:45:49 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6bb07d274feso2811695a34.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 15:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690152348; x=1690757148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5+26FcpXkW84rIB6KuyfKNQ7p8OOANr3u9xvhBLvsw=;
        b=TvqwZLJIC7SXI4g7BHfNmvz4zqZ+jD9r0vdDHG02qsl2yAI3uzzqThakFEjSPX+nx4
         /2XZ8+3VqpkY5ey/T6OB1PK0oAlFRp8Cb+0AuH3kUiwGa3PZiOKm+LMjdHcXO6unPu8X
         99L2nr3u/JugEM7KO/947frGjPYn4bOMYq6ktZkMRn194iP3zCp61RX0Jul8rXbmvqXm
         QqXABNZQK8R2DKqQzs+gp5fJow+rTKWSX7vurxJlk00XwIrEk3L2h8vLEAm4/Bvu3on/
         HpN4aPi+5ZVJsZU8jl8O2pvhstfIMKelmoZSXmRhoiCMcYHQSbplIGmgGuuAAp6kPQTe
         qF0Q==
X-Gm-Message-State: ABy/qLajEayOqmL5WqQ3fiK4Wr+tDMTA+FudeQaWULtHEhRMJyUSdc1Z
        dljjjjcRswhhypLBpXwZQxg=
X-Google-Smtp-Source: APBJJlEks0YomwDqWaRLVqljCLqr4flVbSR3Do4rXMQ5/cPRkBYGx6hTUmXgrWChPAdRdkVg0wDTnQ==
X-Received: by 2002:a05:6830:e19:b0:6b9:696d:716a with SMTP id do25-20020a0568300e1900b006b9696d716amr4531309otb.18.1690152348703;
        Sun, 23 Jul 2023 15:45:48 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902a41200b001bb9f104333sm1135878plq.12.2023.07.23.15.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 15:45:48 -0700 (PDT)
Date:   Sun, 23 Jul 2023 22:45:46 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [patch 48/58] x86/apic: Nuke ack_APIC_irq()
Message-ID: <ZL2tmo/wNYNNj2qO@liuwe-devbox-debian-v2>
References: <20230717223049.327865981@linutronix.de>
 <20230717223225.937554398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717223225.937554398@linutronix.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 01:15:49AM +0200, Thomas Gleixner wrote:
> Yet another wrapper of a wrapper gone along with the outdated comment
> that this compiles to a single instruction.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
