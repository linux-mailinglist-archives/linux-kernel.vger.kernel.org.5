Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1A080BBB5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 15:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjLJO0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 09:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjLJO0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 09:26:09 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485A0C2;
        Sun, 10 Dec 2023 06:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1702218374;
        bh=WfOzir+oTf44dYxvkiIaqqI0cQqL7L27KViNh2TxyJg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P73w9OEdofIgWwoJOf+aGtqyasboZtm4H22KuOFqIxcVDEjFLFo+WEYCqP3PG7hFL
         TpFPDKBbWvs2KNmsnUrO8ZoySvKipzM7vM/uI6/FHdTB34H90C7CO42qADbpec61qG
         5tAqaFKGh8aJFp5bFRCcsUUS0pKUOZLTlzmF5qlkwMHCOoKL/cvLNUz1wxrBRjLlSz
         LEO4p9YXoyiRjyPj/A2Kr7ta0fWLVzXMjc92VtElsOAGhVMts7oBGbOHIWk9HVsZid
         Nn7S5k7QOQ28IknFY4fB1k0yvFHicO3Wpc0XDNMb+6zVw8fGqyDC1JiQnmd2eyP1KD
         3HJkBDv72HDyw==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Sp6ck3NNyzG77;
        Sun, 10 Dec 2023 09:26:14 -0500 (EST)
Message-ID: <3b45bdf6-234d-4859-8344-c18b48c8b415@efficios.com>
Date:   Sun, 10 Dec 2023 09:26:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] ringbuffer/selftest: Add basic selftest to test
 chaning subbuf order
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
References: <20231210035404.053677508@goodmis.org>
 <20231210040452.274868572@goodmis.org>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231210040452.274868572@goodmis.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-09 22:54, Steven Rostedt wrote:
[...]
> +get_buffer_data_size() {
> +	sed -ne 's/^.*data.*size:\([0-9][0-9]*\).*/\1/p' events/header_page
> +}
> +
> +a="1234567890"
> +
> +make_str() {
> +        cnt=$1
> +        s=""
> +        while [ $cnt -gt 10 ]; do
> +                s="${s}${a}"
> +                cnt=$((cnt-10))
> +        done
> +        while [ $cnt -gt 0 ]; do
> +                s="${s}X"
> +                cnt=$((cnt-1))
> +        done
> +        echo -n $s
> +}
> +
> +test_buffer() {
> +
> +	size=`get_buffer_data_size`
> +
> +	str=`make_str $size`
> +
> +	echo $str > trace_marker
> +
> +	grep -q $a trace

This test has no clue if the record was truncated or not.

It basically repeats the string

"1234567890" until it fills the subbuffer size and pads with
XXXX as needed as trace marker payload, but the grep looks for the
"1234567890" pattern only.

The test should be extended to validate whether the trace marker
payload was truncated or not, otherwise it is of limited value.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

