Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3E37E8AD4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 13:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjKKMLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 07:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjKKMLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 07:11:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FD23AA6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 04:11:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4064C433C7;
        Sat, 11 Nov 2023 12:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699704660;
        bh=yPCWcBAfG/u6d4A2IxQav/QG52PrTiH0rCXIFF7fnwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n4SuLcF4G96RgHmy7+4Jq4HBt+G8NxoEdOIRGuSf+2JzCR1kVdyIK4M+twtX6PGt0
         U1bnkmvS1bQW2aNomw2+4f+0BTX/Oj99ncE8b4v9XW7naFOQjBLe9VbSYsmg4C4aj/
         n0K7k16rzOPzd9+SQu2NFndEGd7TWH9Zqy+5WkCqrkxYpM+ouZotUI1fj6Jwfd72cc
         NRHHhUWYgk7lTdngMYIBYfX29ti0+GfzcW/QQvpYeA4qHpiDdG/KG8yq0wMg5fKQTI
         ztRnVR6D6S2IrzyOo3gKcT1WTbxM4tvALgfMPo++H20XJGoM4sYK5nepUIKy8JqtCK
         W0yxBGG7wxwgQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F276F40094; Sat, 11 Nov 2023 09:10:56 -0300 (-03)
Date:   Sat, 11 Nov 2023 09:10:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        sumanthk@linux.ibm.com, svens@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH v3] perf report: Add s390 raw data interpretation for PAI
 counters
Message-ID: <ZU9vUEzF4opW5Gb/@kernel.org>
References: <20231110110908.2312308-1-tmricht@linux.ibm.com>
 <ZU4d0G23WOKwpIwb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZU4d0G23WOKwpIwb@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 10, 2023 at 09:10:56AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Nov 10, 2023 at 12:09:08PM +0100, Thomas Richter escreveu:
> > commit 1bf54f32f525 ("s390/pai: Add support for cryptography counters")
> 
> Where is this commit?
> 
> ⬢[acme@toolbox perf-tools-next]$ git remote update torvalds
> Fetching torvalds
> remote: Enumerating objects: 25591, done.
> remote: Counting objects: 100% (12820/12820), done.
> remote: Compressing objects: 100% (2379/2379), done.
> remote: Total 9481 (delta 8254), reused 8289 (delta 7086), pack-reused 0
> Receiving objects: 100% (9481/9481), 1.76 MiB | 2.89 MiB/s, done.
> Resolving deltas: 100% (8254/8254), completed with 1792 local objects.
> From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux
>    d2f51b3516dade79..89cdf9d556016a54  master     -> torvalds/master
> ⬢[acme@toolbox perf-tools-next]$ git show 1bf54f32f525
> fatal: ambiguous argument '1bf54f32f525': unknown revision or path not in the working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
> ⬢[acme@toolbox perf-tools-next]$
> 
> Looking using the description I get:
> 
> 39d62336f5c126ad s390/pai: add support for cryptography counters
> 
> Is this the one?
> 
> - Arnaldo
> 
> > added support for Processor Activity Instrumentation Facility (PAI)
> > counters.  These counters values are added as raw data with the perf
> > sample during perf record.
> > Now add support to display these counters in perf report command.
> > The counter number, its assigned name and value is now printed in
> > addition to the hexadecimal output.
> > 
> > Output before:
> >  # perf report -D
> > 
> >  6 514766399626050 0x7b058 [0x48]: PERF_RECORD_SAMPLE(IP, 0x1):
> > 				303977/303977: 0 period: 1 addr: 0
> >  ... thread: paitest:303977
> >  ...... dso: <not found>
> > 
> >  0x7b0a0@/root/perf.data.paicrypto [0x48]: event: 9
> >  .
> >  . ... raw event: size 72 bytes
> >  . 0000:  00 00 00 09 00 01 00 48 00 00 00 00 00 00 00 00  .......H........
> >  . 0010:  00 04 a3 69 00 04 a3 69 00 01 d4 2d 76 de a0 bb  ...i...i...-v...
> >  . 0020:  00 00 00 00 00 01 5c 53 00 00 00 06 00 00 00 00  ......\S........
> >  . 0030:  00 00 00 00 00 00 00 01 00 00 00 0c 00 07 00 00  ................
> >  . 0040:  00 00 00 53 96 af 00 00                          ...S....
> > 
> > Output after:
> >  # perf report -D
> > 
> >  6 514766399626050 0x7b058 [0x48]: PERF_RECORD_SAMPLE(IP, 0x1):
> > 				303977/303977: 0 period: 1 addr: 0
> >  ... thread: paitest:303977
> >  ...... dso: <not found>
> > 
> >  0x7b0a0@/root/perf.data.paicrypto [0x48]: event: 9
> >  .
> >  . ... raw event: size 72 bytes
> >  . 0000:  00 00 00 09 00 01 00 48 00 00 00 00 00 00 00 00  .......H........
> >  . 0010:  00 04 a3 69 00 04 a3 69 00 01 d4 2d 76 de a0 bb  ...i...i...-v...
> >  . 0020:  00 00 00 00 00 01 5c 53 00 00 00 06 00 00 00 00  ......\S........
> >  . 0030:  00 00 00 00 00 00 00 01 00 00 00 0c 00 07 00 00  ................
> >  . 0040:  00 00 00 53 96 af 00 00                          ...S....
> > 
> >         Counter:007 km_aes_128 Value:0x00000000005396af     <--- new
> > 
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Tested-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> > Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> > ---
> >  tools/perf/util/s390-cpumcf-kernel.h |   2 +
> >  tools/perf/util/s390-sample-raw.c    | 104 ++++++++++++++++++++++++---
> >  2 files changed, 98 insertions(+), 8 deletions(-)
> > 
> > diff --git a/tools/perf/util/s390-cpumcf-kernel.h b/tools/perf/util/s390-cpumcf-kernel.h
> > index f55ca07f3ca1..74b36644e384 100644
> > --- a/tools/perf/util/s390-cpumcf-kernel.h
> > +++ b/tools/perf/util/s390-cpumcf-kernel.h
> > @@ -12,6 +12,8 @@
> >  #define	S390_CPUMCF_DIAG_DEF	0xfeef	/* Counter diagnostic entry ID */
> >  #define	PERF_EVENT_CPUM_CF_DIAG	0xBC000	/* Event: Counter sets */
> >  #define PERF_EVENT_CPUM_SF_DIAG	0xBD000 /* Event: Combined-sampling */
> > +#define PERF_EVENT_PAI_CRYPTO_ALL	0x1000 /* Event: CRYPTO_ALL */
> > +#define PERF_EVENT_PAI_NNPA_ALL	0x1800 /* Event: NNPA_ALL */
> >  
> >  struct cf_ctrset_entry {	/* CPU-M CF counter set entry (8 byte) */
> >  	unsigned int def:16;	/* 0-15  Data Entry Format */
> > diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
> > index 115b16edb451..d4dc84aa889a 100644
> > --- a/tools/perf/util/s390-sample-raw.c
> > +++ b/tools/perf/util/s390-sample-raw.c
> > @@ -125,6 +125,9 @@ static int get_counterset_start(int setnr)
> >  		return 128;
> >  	case CPUMF_CTR_SET_MT_DIAG:		/* Diagnostic counter set */
> >  		return 448;
> > +	case PERF_EVENT_PAI_NNPA_ALL:		/* PAI NNPA counter set */
> > +	case PERF_EVENT_PAI_CRYPTO_ALL:		/* PAI CRYPTO counter set */
> > +		return setnr;
> >  	default:
> >  		return -1;
> >  	}
> > @@ -212,27 +215,112 @@ static void s390_cpumcfdg_dump(struct perf_pmu *pmu, struct perf_sample *sample)
> >  	}
> >  }
> >  
> > +/*
> > + * Check for consistency of PAI_CRYPTO/PAI_NNPA raw data.
> > + */
> > +struct pai_data {		/* Event number and value */
> > +	u16 event_nr;
> > +	u64 event_val;
> > +} __packed;


We'll have to disable this warning:

  19    10.55 debian:experimental-x-mips    : FAIL gcc version 12.3.0 (Debian 12.3.0-6)
    util/s390-sample-raw.c:222:13: error: packed attribute causes inefficient alignment for 'event_nr' [-Werror=attributes]
      222 |         u16 event_nr;
          |             ^~~~~~~~
    cc1: all warnings being treated as errors
  20    10.58 debian:experimental-x-mips64  : FAIL gcc version 12.3.0 (Debian 12.3.0-6)
    util/s390-sample-raw.c:222:13: error: packed attribute causes inefficient alignment for 'event_nr' [-Werror=attributes]
      222 |         u16 event_nr;
          |             ^~~~~~~~
    cc1: all warnings being treated as errors
  21    10.89 debian:experimental-x-mipsel  : FAIL gcc version 12.3.0 (Debian 12.3.0-6)
    util/s390-sample-raw.c:222:13: error: packed attribute causes inefficient alignment for 'event_nr' [-Werror=attributes]
      222 |         u16 event_nr;
          |             ^~~~~~~~
    cc1: all warnings being treated as errors

Like I did in:

commit a399ee6773d6a0203f9bd764f8bd9d978878cef1
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Thu Nov 9 16:34:09 2023 -0300

    tools: Disable __packed attribute compiler warning due to -Werror=attributes

    +++ b/tools/include/asm-generic/unaligned.h
@@ -8,6 +8,7 @@
  */
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wpacked"
+#pragma GCC diagnostic ignored "-Wattributes"

I'll do it while waiting for flights later today.

- Arnaldo

> > +/*
> > + * Test for valid raw data. At least one PAI event should be in the raw
> > + * data section.
> > + */
> > +static bool s390_pai_all_test(struct perf_sample *sample)
> > +{
> > +	unsigned char *buf = sample->raw_data;
> > +	size_t len = sample->raw_size;
> > +
> > +	if (len < 0xa || !buf)
> > +		return false;
> > +	return true;
> > +}
> > +
> > +static void s390_pai_all_dump(struct evsel *evsel, struct perf_sample *sample)
> > +{
> > +	size_t len = sample->raw_size, offset = 0;
> > +	unsigned char *p = sample->raw_data;
> > +	const char *color = PERF_COLOR_BLUE;
> > +	struct pai_data pai_data;
> > +	char *ev_name;
> > +
> > +	while (offset < len) {
> > +		memcpy(&pai_data.event_nr, p, sizeof(pai_data.event_nr));
> > +		pai_data.event_nr = be16_to_cpu(pai_data.event_nr);
> > +		p += sizeof(pai_data.event_nr);
> > +		offset += sizeof(pai_data.event_nr);
> > +
> > +		memcpy(&pai_data.event_val, p, sizeof(pai_data.event_val));
> > +		pai_data.event_val = be64_to_cpu(pai_data.event_val);
> > +		p += sizeof(pai_data.event_val);
> > +		offset += sizeof(pai_data.event_val);
> > +
> > +		ev_name = get_counter_name(evsel->core.attr.config,
> > +					   pai_data.event_nr, evsel->pmu);
> > +		color_fprintf(stdout, color, "\tCounter:%03d %s Value:%#018lx\n",
> > +			      pai_data.event_nr, ev_name ?: "<unknown>",
> > +			      pai_data.event_val);
> > +		free(ev_name);
> > +
> > +		if (offset + 0xa > len)
> > +			break;
> > +	}
> > +	color_fprintf(stdout, color, "\n");
> > +}
> > +
> >  /* S390 specific trace event function. Check for PERF_RECORD_SAMPLE events
> > - * and if the event was triggered by a counter set diagnostic event display
> > - * its raw data.
> > + * and if the event was triggered by a
> > + * - counter set diagnostic event
> > + * - processor activity assist (PAI) crypto counter event
> > + * - processor activity assist (PAI) neural network processor assist (NNPA)
> > + *   counter event
> > + * display its raw data.
> >   * The function is only invoked when the dump flag -D is set.
> > + *
> > + * Function evlist__s390_sample_raw() is defined as call back after it has
> > + * been verified that the perf.data file was created on s390 platform.
> >   */
> > -void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event, struct perf_sample *sample)
> > +void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event,
> > +			     struct perf_sample *sample)
> >  {
> > +	const char *pai_name;
> >  	struct evsel *evsel;
> >  
> >  	if (event->header.type != PERF_RECORD_SAMPLE)
> >  		return;
> >  
> >  	evsel = evlist__event2evsel(evlist, event);
> > -	if (evsel == NULL ||
> > -	    evsel->core.attr.config != PERF_EVENT_CPUM_CF_DIAG)
> > +	if (!evsel)
> >  		return;
> >  
> >  	/* Display raw data on screen */
> > -	if (!s390_cpumcfdg_testctr(sample)) {
> > -		pr_err("Invalid counter set data encountered\n");
> > +	if (evsel->core.attr.config == PERF_EVENT_CPUM_CF_DIAG) {
> > +		if (!evsel->pmu)
> > +			evsel->pmu = perf_pmus__find("cpum_cf");
> > +		if (!s390_cpumcfdg_testctr(sample))
> > +			pr_err("Invalid counter set data encountered\n");
> > +		else
> > +			s390_cpumcfdg_dump(evsel->pmu, sample);
> >  		return;
> >  	}
> > -	s390_cpumcfdg_dump(evsel->pmu, sample);
> > +
> > +	switch (evsel->core.attr.config) {
> > +	case PERF_EVENT_PAI_NNPA_ALL:
> > +		pai_name = "NNPA_ALL";
> > +		break;
> > +	case PERF_EVENT_PAI_CRYPTO_ALL:
> > +		pai_name = "CRYPTO_ALL";
> > +		break;
> > +	default:
> > +		return;
> > +	}
> > +
> > +	if (!s390_pai_all_test(sample)) {
> > +		pr_err("Invalid %s raw data encountered\n", pai_name);
> > +	} else {
> > +		if (!evsel->pmu)
> > +			evsel->pmu = perf_pmus__find_by_type(evsel->core.attr.type);
> > +		s390_pai_all_dump(evsel, sample);
> > +	}
> >  }
> > -- 
> > 2.41.0
> > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
