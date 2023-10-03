Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A347D7B7077
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240746AbjJCSCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 14:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240719AbjJCSCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:02:00 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EB3C6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 11:01:55 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c5db4925f9so636855ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 11:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696356115; x=1696960915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WIEs0spWhvaEHG95pFwuv48zQavbPlVczjWUoofRLvY=;
        b=Q07yIE+9jrF6GbHU+6dioZLA/BkJE7GfUkZxXGIV29uqDGdBoSscyMPRxTxUkHTek3
         vPGCAiB1rWQFUFYLJB2C38oa/3b2Tj5Tiq1mfPPkUxDU70Kzz3VFET3NAFXz+/APmVCG
         oW8lNredpQ+e3ijEmsS5qKia1XGDy3ZnS7ZAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696356115; x=1696960915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIEs0spWhvaEHG95pFwuv48zQavbPlVczjWUoofRLvY=;
        b=gqn6ydHUH9GV2o+bXrWEYXgJs5ayBAuGql9fdvDbNeE/F/WIx1YRCLPsHYr1se1YZd
         h3w7vupF1SVpCCfcv7YklEWh/UF224p8lfUArIEz3lOywBWBJFO0Muy8tam8gXNPNUEZ
         +5DLazeNFeTXvubQbokbJGNxZukvxzXRvIQMv93AdvEQ/qvqMQk6qfUbYlvUJ3HGGTlp
         /T3uBkH+X5H/Gp6IX3JRDf07xm/8zrS7+7Z3euM27eXvOoUny5TP5Vlhy/4sRtvk8XOc
         Z3YWVpmQKdKb+KBfql2lmzhWRrX0W3n6NhRGEi+fwprsXYGLqYEiecDfQqYETQn0Qst8
         LSWQ==
X-Gm-Message-State: AOJu0YxqZe/Wum0cnSeixLjm253RX7Bk5wLhzJNBuZSKmiyBeZR0kv1n
        emQjECeEnyaz5peGb2FqQxagEQ==
X-Google-Smtp-Source: AGHT+IGQuYedujS5kNDFRvw8q00AWr3VtUBV4px6923t5RAzuQtWsRlCcwky6+l2eLHYCuoFEf4m6w==
X-Received: by 2002:a17:902:ab4a:b0:1c6:2866:5aeb with SMTP id ij10-20020a170902ab4a00b001c628665aebmr4179906plb.9.1696356115345;
        Tue, 03 Oct 2023 11:01:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id be8-20020a170902aa0800b001c74876f032sm1888209plb.162.2023.10.03.11.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 11:01:54 -0700 (PDT)
Date:   Tue, 3 Oct 2023 11:01:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        luto@amacapital.net, wad@chromium.org, alexyonghe@tencent.com
Subject: Re: [RFC PATCH 0/2] seccomp: Split set filter into two steps
Message-ID: <202310031055.3F19F87@keescook>
References: <20231003083836.100706-1-hengqi.chen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003083836.100706-1-hengqi.chen@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 08:38:34AM +0000, Hengqi Chen wrote:
> This patchset introduces two new operations which essentially
> splits the SECCOMP_SET_MODE_FILTER process into two steps:
> SECCOMP_LOAD_FILTER and SECCOMP_ATTACH_FILTER.
> 
> The SECCOMP_LOAD_FILTER loads the filter and returns a fd
> which can be pinned to bpffs. This extends the lifetime of the
> filter and thus can be reused by different processes.
> With this new operation, we can eliminate a hot path of JITing
> BPF program (the filter) where we apply the same seccomp filter
> to thousands of micro VMs on a bare metal instance.
> 
> The SECCOMP_ATTACH_FILTER is used to attach a loaded filter.
> The filter is represented by a fd which is either returned
> from SECCOMP_LOAD_FILTER or obtained from bpffs using bpf syscall.

Interesting! I like this idea, thanks for writing it up.

Two design notes:

- Can you reuse/refactor seccomp_prepare_filter() instead of duplicating
  the logic into two new functions?

- Is there a way to make sure the BPF program coming from the fd is one
  that was built via SECCOMP_LOAD_FILTER? (I want to make sure we can
  never confuse a non-seccomp program into getting loaded into seccomp.)

-Kees

-- 
Kees Cook
