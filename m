Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E432B7B8C6E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245321AbjJDTQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245440AbjJDTPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:15:51 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594F81FD7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 12:15:44 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-690bd8f89baso110897b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 12:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696446944; x=1697051744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHunwAXyIAlpJkZ1X2qHH80e7yRTuPzNvptIaNDuaGg=;
        b=CBUkYyC/Kny1APr7C03DXHP8ctNBbx+uZvmHRzrEE3z7pm0IeByLxW2uNNWkui39Fq
         K2G3Vo3DttIqD/Uw5aZ8rvuLzwht4DOjFNUpkd8qfYrxBod7TgOGct/qG2rF+2WnXUYM
         kt9EumcC8KHjWOPc6bfO3OAIG5zs1YLvzUx1zJHqQxEGUWEtrpMVOwB6HTiT30EvXKCb
         QDnNkbfWc8fSDzLtok3VArwKzDZ1nsqYS6eZ58Xlah/CgOXAQ2qsAKNWe2BlvMQmxVNg
         emDW2it2WkpfbymZNX3HvUrKLdu1NR5fXFjrDjFQMMtLx/odbFM6lOeSp7LdB2Foa3XM
         PdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696446944; x=1697051744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHunwAXyIAlpJkZ1X2qHH80e7yRTuPzNvptIaNDuaGg=;
        b=hBT+3aLpJVhGCmf1/QodlIdEoLDAvQfLZ6/rDS/iUD9z0ssXSm88tXhVqL3Ech0FH6
         jgNYV3sFyRHcWrxk+UNok3+GOVEynLdWiaaAs4NbMD/4CxA9GKSScovtCYKmMerYtJYp
         dz/jdGu4F9XQKpZxhCX1fZij/SZ+yBPrD9pIJswyPqd48PDZ8dDLCLqDhot5tVv/eMvW
         5SHELxNAsU46O8NOhnkpQHrviMlirJdXNHqMJmDzUk01DB5WNuSoEbhvcBgsIRXaKgla
         ZHqBPyEc6GqLuAg68CI2/QRIvDBmYQD1MyOV+xtC9+mYwdZHUfI+0HyFw6KoGlC2IdQv
         Ta8A==
X-Gm-Message-State: AOJu0YxFtw2WmRYlTxTDS0g8hOAKwg1NmWELcytUSWXsnjHzrHROWTMv
        WKIS8ChjnWrJK9ADf8Ztk5c=
X-Google-Smtp-Source: AGHT+IGoQNHo5eweoid0TLKRq9n7UKcMlNiEpfVtHlfHGVhYMO6F2A+QShkVcuuKf4F0CYTQLoEWZw==
X-Received: by 2002:a05:6a21:3d8b:b0:15d:9d8e:ad8b with SMTP id bj11-20020a056a213d8b00b0015d9d8ead8bmr3280857pzc.32.1696446943667;
        Wed, 04 Oct 2023 12:15:43 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:cef])
        by smtp.gmail.com with ESMTPSA id ji17-20020a170903325100b001c444106bcasm4109960plb.46.2023.10.04.12.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 12:15:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 4 Oct 2023 09:15:41 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     jiangshanlai@gmail.com, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] workqueue: Fix UAF report by KASAN in
 pwq_release_workfn()
Message-ID: <ZR253RO-apOz0DUg@slm.duckdns.org>
References: <20230920060704.24981-1-qiang.zhang1211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920060704.24981-1-qiang.zhang1211@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 02:07:04PM +0800, Zqiang wrote:
> Currently, for UNBOUND wq, if the apply_wqattrs_prepare() return error,
> the apply_wqattr_cleanup() will be called and use the pwq_release_worker
> kthread to release resources asynchronously. however, the kfree(wq) is
> invoked directly in failure path of alloc_workqueue(), if the kfree(wq)
> has been executed and when the pwq_release_workfn() accesses wq, this
> leads to the following scenario:

Applied to cgroup/for-6.6-fixes.

Thanks.

-- 
tejun
