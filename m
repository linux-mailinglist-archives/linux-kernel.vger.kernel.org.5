Return-Path: <linux-kernel+bounces-106547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6D887F028
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D6D1F223AB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C7B56468;
	Mon, 18 Mar 2024 19:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0M4QTAd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D721E52F;
	Mon, 18 Mar 2024 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710788845; cv=none; b=qCRu/s91H0ECVg651AfjhOh81GM2VVPT6m2YuWgvdydEJna96qpluWESUDcaSblnifgEqPkDa8HD+evfVD/txNYQC+Mtd46lvufgE4/R9ZxvQc4mqMcbnZVv0YsbCKEabH7Kc8WGE+vDxwEnGep7aWa8MDTqW/Qk5UkOldV0ruQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710788845; c=relaxed/simple;
	bh=crlDe0LQdyFAPw+Ob2pqUFnMhq9i3YBhAXnA6BrWdOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YtmbPc7Ka5+hOSrxzsFZoLn+4ufw/Q6CBf2m2QuD3zV5sCb/9X1PTRpPx6HV4HQGAuPH4CayrUQTkRsTlcxhAMfFvowAIm85FS9hNJ8IKza3RIj8bgcWncI7/ypSBiFiSF2REiX6kfJ4D6vOyk6/pmfVI8dTtMQkp9+p1z/GpRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0M4QTAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31146C433C7;
	Mon, 18 Mar 2024 19:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710788844;
	bh=crlDe0LQdyFAPw+Ob2pqUFnMhq9i3YBhAXnA6BrWdOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j0M4QTAdmJE03FfauobXexJMJwG/HkoipIXA9CIs5F02BZXqOR3kwWb5DmzctyRfY
	 jpqk4HHl+04/FKrPeHBWoYcCArIW/BM4bHV8zcFeHDr5SvjqKCqLSK3zcBiEURlC5o
	 EbKnnXIljCGpJ63vPrj1L+TFS/Nm1KZcj/sNFVgyWeVMlzB7UEgtCP3Ly5HnFWxOp8
	 UQxNUKp7oj8UqrJrT/a/yBQMGxpRX/X94HciY+en08jv+iLtGzWfOiLOHNxbrM70j8
	 8kFEUp9os2ayya+gqgYqcx3ZdmRmMrPdD8MZTZqoItoZnqzp3hT2zW8sII0tQb4f3V
	 6/Ri3Pdqa0pQQ==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	42.hyeyoo@gmail.com
Subject: Re: [RFC PATCH v2 0/7] DAMON based 2-tier memory management for CXL memory
Date: Mon, 18 Mar 2024 12:07:21 -0700
Message-Id: <20240318190721.99659-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240318132749.2115-1-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 18 Mar 2024 22:27:45 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> Hi SeongJae,
> 
> On Sun, 17 Mar 2024 08:31:44 -0700 SeongJae Park <sj@kernel.org> wrote:
> > Hi Honggyu,
> > 
> > On Sun, 17 Mar 2024 17:36:29 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> > 
> > > Hi SeongJae,
> > > 
> > > Thanks for the confirmation.  I have a few comments on young filter so
> > > please read the inline comments again.
> > > 
> > > On Wed, 12 Mar 2024 08:53:00 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > > Hi Honggyu,
> > > > 
> > > > > > -----Original Message-----
> > > > > > From: SeongJae Park <sj@kernel.org>
> > > > > > Sent: Tuesday, March 12, 2024 3:33 AM
> > > > > > To: Honggyu Kim <honggyu.kim@sk.com>
> > > > > > Cc: SeongJae Park <sj@kernel.org>; kernel_team <kernel_team@skhynix.com>
> > > > > > Subject: RE: Re: [RFC PATCH v2 0/7] DAMON based 2-tier memory management for CXL memory
> > > > > >
> > > > > > Hi Honggyu,
> > > > > >
> > > > > > On Mon, 11 Mar 2024 12:51:12 +0000 "honggyu.kim@sk.com" <honggyu.kim@sk.com> wrote:
> > > > > >
> > > > > > > Hi SeongJae,
> > > > > > >
> > > > > > > I've tested it again and found that "young" filter has to be set
> > > > > > > differently as follows.
> > > > > > > - demote action: set "young" filter with "matching" true
> > > > > > > - promote action: set "young" filter with "matching" false
> 
> Thinking it again, I feel like "matching" true or false looks quite
> vague to me as a general user.
> 
> Instead, I would like to have more meaningful names for "matching" as
> follows.
> 
> - matching "true" can be either (filter) "out" or "skip".
> - matching "false" can be either (filter) "in" or "apply".

I agree the naming could be done much better.  And thank you for the nice
suggestions.  I have a few concerns, though.

Firstly, increasing the number of behavioral concepts.  DAMOS filter feature
has only single behavior: excluding some types of memory from DAMOS action
target.  The "matching" is to provide a flexible way for further specifying the
target to exclude in a bit detail.  Without it, we would need non-variant for
each filter type.  Comapred to the current terms, the new terms feel like
implying there are two types of behaviors.  I think one behavior is easier to
understand than two behaviors, and better match what internal code is doing.

Secondly, ambiguity in "in" and "apply".  To me, the terms sound like _adding_
something more than _excluding_.  I think that might confuse people in some
cases.  Actually, I have used the term "filter-out" and "filter-in" on
this  and several threads.  When saying about "filter-in" scenario, I had to
emphasize the fact that it is not adding something but excluding others.  I now
think that was not a good approach.

Finally, "apply" sounds a bit deterministic.  I think it could be a bit
confusing in some cases such as when using multiple filters in a combined way.
For example, if we have two filters for 1) "apply" a memcg and 2) skip anon
pages, the given DAMOS action will not be applied to anon pages of the memcg.
I think this might be a bit confusing.

> 
> Internally, the type of "matching" can be boolean, but it'd be better
> for general users have another ways to set it such as "out"/"in" or
> "skip"/"apply" via sysfs interface.  I prefer "skip" and "apply" looks
> more intuitive, but I don't have strong objection on "out" and "in" as
> well.

Unfortunately, DAMON sysfs interface is an ABI that we want to keep stable.  Of
course we could make some changes on it if really required.  But I'm unsure if
the problem of current naming and benefit of the sugegsted change are big
enough to outweighs the stability risk and additional efforts.

Also, DAMON sysfs interface is arguably not for _very_ general users.  DAMON
user-space tool is the one for _more_ general users.  To quote DAMON usage
document,

    - *DAMON user space tool.*
      `This <https://github.com/awslabs/damo>`_ is for privileged people such as
      system administrators who want a just-working human-friendly interface.
      [...]
    - *sysfs interface.*
      :ref:`This <sysfs_interface>` is for privileged user space programmers who
      want more optimized use of DAMON. [...]
 
If the concept is that confused, I think we could improve the documentation, or
the user space tool.  But for DAMON sysfs interface, I think we need more
discussions for getting clear pros/cons that justifies the risk and the effort.

> 
> I also feel the filter name "young" is more for developers not for
> general users.  I think this can be changed to "accessed" filter
> instead.

In my humble opinion, "accessed" might be confusing with the term that being
used by DAMON, specifically, the concept of "nr_accesses".  I also thought
about using more specific term such as "pg-accessed" or something else, but I
felt it is still unclear or making it too verbose.

I agree "young" sounds more for developers.  But, again, DAMON sysfs is for not
_very_ general users.  And the term is used commonly on relcaimation part and
LRU, so I think this is not too bad as long as we provide nice documentation or
abstraction from user-space tool.

> 
> The demote and promote filters can be set as follows using these.
> 
> - demote action: set "accessed" filter with "matching" to "skip"
> - promote action: set "accessed" filter with "matching" to "apply"
> 
> I also think that you can feel this is more complicated so I would like
> to hear how you think about this.

To my humble brain, this looks intuitive for this use case.  But as I also
mentioned above, I worry if this could keep simple and intuitive in complicated
filter usages.

> 
> > > > > >
> > > > > > DAMOS filter is basically for filtering "out" memory regions that matches to
> > > > > > the condition.
> 
> Right.  In other tools, I see filters are more used as filtering "in"
> rather than filtering "out".  I feel this makes me more confused.

I understand that the word, "filtering", can be used for both, and therefore
can be confused.  I was also spending no small times at naming since I was
thinking about both coffee filters and color filters (of photoshop or glasses).
But it turned out that I'm more familiar with coffee filters, and might be same
for DAMON community, since the community is having beer/coffee/tea chat series
;) (https://lore.kernel.org/damon/20220810225102.124459-1-sj@kernel.org/)

That said, I think we may be able to make this better documented, or add a
layer of abstraction on DAMON user-space tool.

[...]
> > > > > Yes, I understand "promote non-non-young pages" means "promote young pages".
> > > > > This might be understood as "young pages are NOT filtered out" for promotion
> > > > > but it doesn't mean that "old pages are filtered out" instead.
> > > > > And we just rely hot detection only on DAMOS logics such as access frequency
> > > > > and age. Am I correct?
> > > > 
> > > > You're correct.
> > > 
> > > Ack.  But if it doesn't mean that "old pages are filtered out" instead,
> > 
> > It does mean that.  Here, filtering is exclusive.  Hence, "filter-in a type of
> > pages" means "filter-out pages of other types".  At least that's the intention.
> > To quote the documentation
> > (https://docs.kernel.org/mm/damon/design.html#filters),
> > 
> >     Each filter specifies the type of target memory, and whether it should
> >     exclude the memory of the type (filter-out), or all except the memory of
> >     the type (filter-in).
> 
> Thanks for the correction.
> 
> > > then do we really need this filter for promotion?  If not, maybe should
> > > we create another "old" filter for promotion?  As of now, the promotion
> > > is mostly done inaccurately, but the accurate migration is done at
> > > demotion level.
> > 
> > Is this based on your theory?  Or, a real behavior that you're seeing from your
> > setup?  If this is a real behavior, I think that should be a bug that need to
> > be fixed.
> 
> I have observed this in the hot_cold example, but I also found that the
> promotion is done very quickly because the age for promote action is set
> to 0 to max in my json setup.  It makes most pages of the region are
> young because there is not enough time for those pages being old.  That
> means I was wrong.
[...]
> > > I understand the function name of internal implementation is
> > > "damos_pa_filter_out" so the basic action is filtering out, but the
> > > cgroup filter works in the opposite way for now.
> > 
> > Does memcg filter works in the opposite way?  I don't think so because
> > __damos_pa_filter_out() sets 'matches' as 'true' only if the the given folio is
> > contained in the given memcg.  'young' filter also simply sets 'matches' as
> > 'true' only if the given folio is young.
> > 
> > If it works in the opposite way, it's a bug that need to be fixed.  Please let
> > me know if I'm missing something.
> 
> No, it was also my misunderstanding.  I used to set the matching false
> using my script.

Thank you for confirming.  I understand we found no bug at the moment.


To summarize my opinion again,

1. I agree the concept and names of DAMOS filters are confusing and not very
   intuitive.
2. However, it's unclear if the problem and the benefit from the suggested new
   names are huge enough to take the risk and effort on changing ABI.
3. We could improve documentation and/or user-space tool.

Thank you again for the suggestion and confirmations to my questions.


Thanks,
SJ

[...]

