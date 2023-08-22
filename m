Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C541783736
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 03:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjHVBHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 21:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHVBHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 21:07:08 -0400
Received: from out-61.mta0.migadu.com (out-61.mta0.migadu.com [91.218.175.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E06187
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 18:07:00 -0700 (PDT)
Message-ID: <88ba3052-9e09-af0d-347e-2a8e8b043617@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692666418; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=57xPwBg/RZutLMRYrXA0pEFYLV8BOzmSCdB6PB/RU30=;
        b=Wf00TOXdBv3SQo3aZPTQAriuEdYW9tHXRzzFqGroEGPwj1y1aYNgF8sULURZaweBtgakrq
        MnZxH9tRhTDJsxVI9+LctQUsKMjPGdARyCr2rleR0PW6WELgmBhGfXQlJDVg3ZXqF61cvH
        P6+lHqBFjlpKcdyVncqJJi1cXh0V3zw=
Date:   Mon, 21 Aug 2023 18:06:47 -0700
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH] bpf: task_group_seq_get_next: cleanup the usage of
 get/put_task_struct
Content-Language: en-US
To:     Oleg Nesterov <oleg@redhat.com>, Yonghong Song <yhs@fb.com>,
        Kui-Feng Lee <kuifeng@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230821150909.GA2431@redhat.com>
 <20230821200311.GA22497@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230821200311.GA22497@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/23 1:03 PM, Oleg Nesterov wrote:
> get_pid_task() makes no sense, the code does put_task_struct() soon after.
> Use find_task_by_pid_ns() instead of find_pid_ns + get_pid_task and kill
> kill put_task_struct(), this allows to do get_task_struct() only once

remove the duplicated 'kill' in the above.

> before return.
> 
> While at it, kill the unnecessary "if (!pid)" check in the "if (!*tid)"
> block, this matches the next usage of find_pid_ns() + get_pid_task() in
> this function.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

LGTM.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
