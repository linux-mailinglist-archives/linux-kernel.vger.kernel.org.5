Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4067EB6B9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 20:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjKNTHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 14:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKNTHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 14:07:08 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F658FB;
        Tue, 14 Nov 2023 11:07:05 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6bd73395bceso89017b3a.0;
        Tue, 14 Nov 2023 11:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699988825; x=1700593625; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=crYXZ2+TGefE1MZr1CPzuD2Ao+ZCyPvBl9mPlHWyCHo=;
        b=mjRnM60c2FShnMtUsAE+loAzrOpqK/2Tu3aEyJbI36eqCDMw0ZWXm/0dTNmLVzlMz7
         bfBV566ZpQJReFd91Z/Su2yUH1u1v7A22JjyJLYE1feP4/QqqAFGIf3Ogwzf0urh3vXR
         nm3pnDCepzN4PX7Fk8gh2Nl05r+tPNzDZbGqgtPpNhfs5A8LSz4PksnomnFqkajbSZrZ
         gXv3i5YV7PiJ6ma/BJGqUJPHW/VyRuqx1VXwCLSMi/wq/krUI+d0+nDbfEYYJV8Ye6lH
         wMx+Z7iNCKQqR5A8KibIoxOejX1dbL0q2HJDkOhsFU8gEim+68drBZ6o9IwR+HchlahV
         ls3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699988825; x=1700593625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=crYXZ2+TGefE1MZr1CPzuD2Ao+ZCyPvBl9mPlHWyCHo=;
        b=tK8/n4fDkRzgi+GLSiPUWHbn4MkEUfRlqGXoAbmx0Kwc4SXjQ+pj1U4UAKUigF0HVz
         cTeuqSMjlRrwUafY8NI2yYWKqAmRgwJM8fy6wYln5Ek69e4fgnyoA72CKHa4r1Pqpavt
         wVz64oclQJbzBsCtN+2Dw532n88P1rqmCcnXyYPhUifzWLY4FWUKDv8fGhXJq66bEVh2
         0FwhENa/vsYPHccnQs35tvidsAQankBHmHy7HPv/bPqVi4BB9PA0vFtSjnzTFXYEE7lW
         +/QlAY5MLYBjnmAfvgxCVveLwC+eurl91w3VRkIGDonRHxqx8Y4qe3Pd2HAs8xTTpmQN
         1jaw==
X-Gm-Message-State: AOJu0Yw1UQPhv5fRvkXisg5yS3y9yVxYBkOwaU9bl0x7pq3Jv+71e5fc
        /erp9iewDRLsz+SCK3vgkv94HOJjQCT6og==
X-Google-Smtp-Source: AGHT+IHCyuSIrFeXT4LI4PV1GZeBni9le0dSGtwI2irVpVJXUj9vzFi6VCyrwLxbsWv0Man+4Ouk2w==
X-Received: by 2002:a05:6a20:1b26:b0:151:35ad:f331 with SMTP id ch38-20020a056a201b2600b0015135adf331mr3688236pzb.14.1699988824868;
        Tue, 14 Nov 2023 11:07:04 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id o21-20020a63fb15000000b005b7e803e672sm6036934pgh.5.2023.11.14.11.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 11:07:04 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 14 Nov 2023 09:07:03 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Changwoo Min <changwoo@igalia.com>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        himadrics@inria.fr, memxor@gmail.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@meta.com,
        Andrea Righi <andrea.righi@canonical.com>,
        kernel-dev@igalia.com
Subject: Re: [PATCH 12/36] sched_ext: Implement BPF extensible scheduler class
Message-ID: <ZVPFV9jG1y3YbJUd@slm.duckdns.org>
References: <20231111024835.2164816-1-tj@kernel.org>
 <20231111024835.2164816-13-tj@kernel.org>
 <c631759f-6e71-4c27-9a56-fc3159793e81@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c631759f-6e71-4c27-9a56-fc3159793e81@igalia.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 10:34:23PM +0900, Changwoo Min wrote:
> Currently, scx_ops_enable_state_str is defined only when
> CONFIG_SCHED_DEBUG is enabled. However, print_scx_info() uses
> scx_ops_enable_state_str regardless that CONFIG_SCHED_DEBUG is enabled
> or not. So when CONFIG_SCHED_DEBUG is not enabled, the current code
> generates the following compilation error:
> 
> kernel/sched/ext.c: In function ‘print_scx_info’:
> kernel/sched/ext.c:3720:24: error: ‘scx_ops_enable_state_str’ undeclared
> 
> So CONFIG_SCHED_DEBUG should be moved to after the definition of
> scx_ops_enable_state_str.

Will fix. Thank you.

-- 
tejun
