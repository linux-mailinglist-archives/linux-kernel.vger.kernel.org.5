Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569737C6A62
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343654AbjJLKEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbjJLKEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:04:33 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3AAC9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:04:29 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-79fa5d9f3a2so32445239f.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697105069; x=1697709869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WXAPa5EKPqpyaUOPwf59NxGETBLmnhLA24XZS+cRTr4=;
        b=B7PXomLWr5xmcdU8i9QVIYXLVFflim5G1xeCCWNwk8KVWhu/1cOmFPDyE9GNPGkBwZ
         +B5SVA39BdBsud6MZnZnzrWZIv1mhQ9ck1dXhUiqK0WS4AKeuXCb52vT3ZG445BAOYlX
         JguI56nygYbpXhjlDeNfb+EXNiF4nuGfEyRasWQgT9JEViVFHaDiXtWnv6wqsZFUKU/v
         ngsK7qfsJjkM5JQhaV4rKww0GG+ulND6UyCB5Hh1/RsOrmhjv6PoZMecTxanll9RX1A/
         R6G1zRaniwurimfW1Qg53Nb/5tv8Danvc2oEehqqqrQOWrHsNQ7bGrq6fbRyHb8ClmDL
         do9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697105069; x=1697709869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXAPa5EKPqpyaUOPwf59NxGETBLmnhLA24XZS+cRTr4=;
        b=wpaDpE7qMZ/NHQrCbiiagToJK+513xOGb/KynOBuWTkJFL8YCmkWW1HtXock6kml+Q
         HmvEpiqHBzcZ6W6v9mSoGuu0VFga9K062Z/nq33mXlV3OIH63yYVxVxSWrjq450WxcOI
         1vwby93/9rJMiaoq6Z0vc0NGR184b8N5wmo/PiiDcolTtdCZyeWVfVKBETMH5RFyu3w4
         RmUWisqP5RM7PBzQj4NA3acldkOYVxKcoaoAq6sMjDIuC9DiN68YFuvBXCmPokBYvPyG
         UpSV6AkQR2JM87a4oH7yTdTPZQHgXIulCAs0ocj2CldPCYiBx3n19ogt1yMF8k47imfV
         wxtw==
X-Gm-Message-State: AOJu0YzClwQ0zo7CdJzE1eqrpoJsd6D/BUe7jh488MxRSLPgxGRMxXPF
        PDa5YwZXOzY6TsIHyieHr9vZLQ==
X-Google-Smtp-Source: AGHT+IH9sCbecXw1T+m6SbsHUtnckxT3g9WhxXS0HJDJYaSPg2iRgoP8OEZLfalbcIkbIQoMMRaWjQ==
X-Received: by 2002:a05:6602:2807:b0:7a5:a391:73ae with SMTP id d7-20020a056602280700b007a5a39173aemr7716132ioe.17.1697105069110;
        Thu, 12 Oct 2023 03:04:29 -0700 (PDT)
Received: from [10.84.153.115] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id y28-20020a056a001c9c00b00690d1269691sm2603788pfw.22.2023.10.12.03.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 03:04:28 -0700 (PDT)
Message-ID: <99cabaee-df77-4da4-9521-3877a507ba48@bytedance.com>
Date:   Thu, 12 Oct 2023 18:04:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correct
 se
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Benjamin Segall <bsegall@google.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bristot@redhat.com,
        corbet@lwn.net, qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
References: <20230531115839.089944915@infradead.org>
 <20230531124603.931005524@infradead.org> <xm261qego72d.fsf_-_@google.com>
 <6b606049-3412-437f-af25-a4c33139e2d8@bytedance.com>
 <20231011131454.GN14330@noisy.programming.kicks-ass.net>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20231011131454.GN14330@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/23 9:14 PM, Peter Zijlstra Wrote:
> On Wed, Oct 11, 2023 at 08:12:09PM +0800, Abel Wu wrote:
> 
> As the paper explains, you get two walks, one down the eligibility path,
> and then one down the heap. I think the current code structure
> represents that fairly well.

Yes, it does. I just wonder if the 2-step search is necessary, since
they obey the same rule of heap search:

   1) node->min_deadline > node->left->min_deadline
	1.1) BUG

   2) node->min_deadline = node->left->min_deadline
	2.1) go left if tiebreak on vruntime

   3) node->min_deadline < node->left->min_deadline
	3.1) return @node if it has min deadline, or
	3.2) go right

which gives:

	while (node) {
		if ((left = node->left)) {
			/* 1.1 */
			BUG_ON(left->min < node->min);

			/* 2.1 */
			if (left->min == node->min) {
				node = left;
				continue;
			}
		}

		/* 3.1 */
		if (node->deadline == node->min)
			return node;

		/* 3.2 */
		node = node->right;
	}

The above returns the entity with ealiest deadline (and with smallest
vruntime if have same deadline). Then comes with eligibility:

   0) it helps pruning the tree since the right subtree of a
      non-eligible node can't contain any eligible node.

   3.2.1) record left as a fallback iff the eligibility check
          is active, and saving the best one is enough since
          none of them contain non-eligible node, IOW the one
          with min deadline in the left tree must be eligible.

   4) the eligibility check ends immediately once go left from
      an eligible node, including switch to the fallback which
      is essentially is the 'left' of an eligible node.

   5) fallback to the candidate (if exists) if failed to find
      an eligible entity with earliest deadline.

which makes:

	candidate = NULL;
	need_check = true;

	while (node) {
		/* 0 */
		if (need_check && !eligible(node)) {
			node = node->left;
			goto next;
		}

		if ((left = node->left)) {
			/* 1.1 */
			BUG_ON(left->min < node->min);

			/* 2.1 */
			if (left->min == node->min) {
				node = left;
				/* 4 */
				need_check = false;
				continue;
			}

			/* 3.2.1 */
			if (need_check)
				candidate = better(candidate, left);
		}

		/* 3.1 */
		if (node->deadline == node->min)
			return node;

		/* 3.2 */
		node = node->right;
	next:
		/* 5 */
		if (!node && candidate) {
			node = candidate;
			need_check = false; /* 4 */
			candidate = NULL;
		}
	}

The search ends with a 'best' entity on the tree, comparing it with
curr which is out of tree makes things a whole.

But it's absolutely fine to me to honor the 2-step search given by
the paper if you think that is already clear enough :)

Best,
	Abel
