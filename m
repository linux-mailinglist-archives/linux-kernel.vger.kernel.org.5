Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5744B79099A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 22:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbjIBUm6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 2 Sep 2023 16:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjIBUm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 16:42:57 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACE2CDA
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 13:42:54 -0700 (PDT)
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 3715FB308A;
        Sat,  2 Sep 2023 20:42:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 1E46F20027;
        Sat,  2 Sep 2023 20:42:49 +0000 (UTC)
Message-ID: <65819b768e01a78c976eaa895c67d9227fe5d3a0.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Avoid warnings for numbered references with
 URL
From:   Joe Perches <joe@perches.com>
To:     Anton Leontiev <aleontiev@elvees.com>, linux-kernel@vger.kernel.org
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sat, 02 Sep 2023 13:42:49 -0700
In-Reply-To: <20230902155006.1561074-1-aleontiev@elvees.com>
References: <20230902155006.1561074-1-aleontiev@elvees.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: 6781wsihon3edy1cqe6kzoq84qn4me4p
X-Rspamd-Server: rspamout07
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Rspamd-Queue-Id: 1E46F20027
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/USlZoyLApmHUU3Gq7IyZRSGmYLg2gRvo=
X-HE-Tag: 1693687369-512447
X-HE-Meta: U2FsdGVkX18qSpZLp+qr58f/gIhfTGi59+r/ZUU/xB41dui1DXhtJRL0ZZ669u9Nw7Sb10uwVuzlpZwgCEi6m7QHggkOg36y5Ar2znsse87GyZ0VoGMbMIuJ9ul3I0VBGr1wGgXrbf5jp2rpChwy7T35o2EW9DZRw0tftdVYkDChGqe536kiPPu3uXSH8xkjyTuMzSyBWt+jGd/aU13yHKDc5J0zIFh3jBkbCMrWpWDrlbV9BqACiaeoqfQUNtuUzPRGezXt+PMAUw+YiekberCqcD1qmwXJ2VuzB2FKPHdRno4sgUxjlrnrb3gK4JJ3nEvK58QOg6pgFjLnp3WSeM3kH0XjnlpQ8zzAJw7awnxiyabgbmCeoQ9CyzAfRNd0
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-09-02 at 18:50 +0300, Anton Leontiev wrote:
> Numbered references is one of the most frequently used ways to link
> external resources and them often exeed 75 chars. Add exception for
> these lines.

Conceptually ok, but there are other non-numbered uses of lists like

	o	link1
	o	link2
		...

or
	1:	link1
	2:	link2
		...

So maybe this should just allow any long line with a uri/url

> 
> Signed-off-by: Anton Leontiev <aleontiev@elvees.com>
> ---
>  scripts/checkpatch.pl | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7d16f863edf1..929574f43d4d 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3270,6 +3270,8 @@ sub process {
>  					# filename then :
>  		      $line =~ /^\s*(?:Fixes:|$link_tags_search|$signature_tags)/i ||
>  					# A Fixes:, link or signature tag line
> +		      $line =~ /^\s*\[\d+\]\s+[a-z][\w\.\+\-]*:\/\/\S+/i ||
> +					# reference with URL
>  		      $commit_log_possible_stack_dump)) {
>  			WARN("COMMIT_LOG_LONG_LINE",
>  			     "Prefer a maximum 75 chars per line (possible unwrapped commit description?)\n" . $herecurr);

